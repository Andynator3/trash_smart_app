import 'package:flutter_bloc/flutter_bloc.dart';
// Pense à importer les fichiers d'états, d'événements et ton repository
import 'auth.event.dart';
import 'auth.state.dart';
import '../../repositories/auth.repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {

    // Écoute de l'événement de connexion
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading()); // Déclenche le spinner visuel

      try {
        // Appel vers le Spring Boot via le Repository
        final success = await authRepository.login(event.username, event.password);

        if (success) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthError("Identifiants incorrects ou problème serveur."));
        }
      } catch (e) {
        emit(AuthError("Une erreur inattendue s'est produite."));
      }
    });

    // Écoute de l'événement de déconnexion
    on<LogoutRequested>((event, emit) async {
      await authRepository.logout();
      emit(AuthInitial()); // Retour à l'écran de login
    });
  }
}
