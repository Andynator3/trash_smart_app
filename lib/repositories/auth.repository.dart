import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  // Injection des dépendances
  AuthRepository({required this.dio, required this.secureStorage});

  // Astuce Ops : Sur l'émulateur Android, localhost correspond à 10.0.2.2
  final String baseUrl = "http://10.0.2.2:8081/api/auth";

  Future<bool> login(String username, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/login',
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // Adapte la clé 'token' selon la structure exacte du JSON renvoyé par ton Spring Boot
        final String jwtToken = response.data['token'];

        // Sauvegarde sécurisée du jeton
        await secureStorage.write(key: 'jwt_token', value: jwtToken);
        return true;
      }
      return false;
    } on DioException catch (e) {
      // Gestion des erreurs HTTP (ex: 401 Unauthorized, 403 Forbidden)
      print('Erreur de connexion : ${e.response?.statusCode} - ${e.message}');
      return false;
    } catch (e) {
      print('Erreur inattendue : $e');
      return false;
    }
  }

  Future<void> logout() async {
    // Suppression du token lors de la déconnexion
    await secureStorage.delete(key: 'jwt_token');
  }

  Future<String?> getToken() async {
    // Récupération du token pour les requêtes futures
    return await secureStorage.read(key: 'jwt_token');
  }
}
