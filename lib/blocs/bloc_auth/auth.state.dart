abstract class AuthState {}

class AuthInitial extends AuthState {} // État de base au lancement
class AuthLoading extends AuthState {} // Affichage du spinner de chargement
class AuthAuthenticated extends AuthState {} // Succès, on redirige vers /home
class AuthError extends AuthState {
  final String message;
  AuthError(this.message); // Affichage du message d'erreur en rouge
}
