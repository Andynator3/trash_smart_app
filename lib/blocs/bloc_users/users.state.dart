import '../../models/users.model.dart';

abstract class UsersState {}
class UsersInitial extends UsersState {}
class UsersLoading extends UsersState {}
class UsersLoaded extends UsersState {
  final UserModel user;
  UsersLoaded(this.user);
}
class UsersError extends UsersState {
  final String message;
  UsersError(this.message);
}
