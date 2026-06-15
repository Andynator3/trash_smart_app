import 'package:dio/dio.dart';
import '../models/users.model.dart';

class UserRepository {
  final Dio dio;

  UserRepository({required this.dio});

  final String baseUrl = "http://10.0.2.2:8081/api/profiles";

  Future<UserModel> getMyProfile() async {
    try {
      final response = await dio.get('$baseUrl/me');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception("Erreur lors de la récupération du profil");
      }
    } catch (e) {
      // Cette ligne va afficher la VRAIE erreur dans la console Run de mon Android Studio
      print('=== ERREUR CRITIQUE API === : $e');
      throw Exception("Erreur de chargement du profil.");
    }
  }
}
