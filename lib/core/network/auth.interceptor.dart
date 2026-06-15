import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  // Injection du stockage sécurisé pour aller lire le token
  AuthInterceptor({required this.secureStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // LIGNE À RAJOUTER : Si la requête va vers l'authentification, on n'ajoute PAS de token
    if (options.path.contains('/api/auth')) {
      return super.onRequest(options, handler); // On laisse passer la requête "nue"
    }

    // Le code existant pour récupérer et ajouter le token
    final token = await secureStorage.read(key: 'jwt_token'); // Vérifie le nom de ta clé

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print("=== TOKEN ENVOYÉ : $token ===");
    return super.onRequest(options, handler);
  }

  /* @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. Récupération du token depuis le coffre-fort d'Android
    final token = await secureStorage.read(key: 'jwt_token');

    // 2. Si le token existe, on l'injecte dans le header de la requête
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print("=== TOKEN ENVOYÉ : $token ===");
    // 3. On laisse la requête continuer son chemin vers le serveur
    super.onRequest(options, handler);
  }*/

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Astuce Ops : Si le serveur renvoie 401 (Non autorisé), le token est expiré.
    // Tu pourras gérer ici la redirection automatique vers la page de login plus tard.
    if (err.response?.statusCode == 401) {
      print("Token expiré ou invalide !");
    }
    super.onError(err, handler);
  }
}
