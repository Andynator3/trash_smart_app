class UserModel {
  final int id;
  final String username;
  final String email;
  final String role;
  // Les champs métiers manquants à ajouter :
  final String firstName;
  final String lastName;
  final String phone;
  final int rewardPoints;
  final bool isLocationAccepted;
  final bool pushNotificationsEnabled;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.rewardPoints,
    required this.isLocationAccepted,
    required this.pushNotificationsEnabled,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'USER',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'] ?? '',
      rewardPoints: json['rewardPoints'] ?? 0,
      isLocationAccepted: json['isLocationAccepted'] ?? false,
      pushNotificationsEnabled: json['pushNotificationsEnabled'] ?? false,
    );
  }
}

/*class UserModel {
  final int id;
  final String username;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
  });

  // Factory pour convertir le JSON de l'API en objet Dart
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'USER',
    );
  }
}*/
