import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/network/auth.interceptor.dart';

// Importations des pages et BLoCs existants
import 'package:trash_smart_app/ui/pages/root.view.dart';
import 'blocs/bloc_themes/theme.bloc.dart';
import 'blocs/bloc_users/users.bloc.dart';
import 'repositories/user.repository.dart';

// Nouvelles importations pour l'authentification
import 'repositories/auth.repository.dart';
import 'blocs/bloc_auth/auth.bloc.dart';

void main() {
  // Obligatoire en Flutter quand on instancie des plugins natifs (comme secure_storage) avant runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialisation de tes services réseau et de stockage au démarrage
  final dio = Dio();
  final secureStorage = const FlutterSecureStorage();

  // Ajout de l'intercepteur à l'instance globale de Dio
  dio.interceptors.add(AuthInterceptor(secureStorage: secureStorage));

  runApp(MyApp(dio: dio, secureStorage: secureStorage));
}

class MyApp extends StatelessWidget {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  const MyApp({
    Key? key,
    required this.dio,
    required this.secureStorage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 2. Couche d'accès aux données (Injection des Repositories)
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(dio: dio, secureStorage: secureStorage),
        ),
        // Tu pourras décommenter ceci quand ton UserRepository sera prêt à être connecté au réseau
         RepositoryProvider<UserRepository>(
           create: (context) => UserRepository(dio: dio),
         ),
      ],

      // 3. Couche Logique (Injection des BLoCs)
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(
            create: (context) => AuthBloc(
              // On récupère le AuthRepository injecté juste au-dessus pour le donner au BLoC
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => UsersBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),
        ],

        // 4. Couche Vue (Interface Graphique)
        child: const RootView(),
      ),
    );
  }
}
