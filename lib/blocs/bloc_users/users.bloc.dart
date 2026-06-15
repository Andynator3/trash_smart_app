import 'package:flutter_bloc/flutter_bloc.dart';
import 'users.event.dart';
import 'users.state.dart';
import '../../repositories/user.repository.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository;

  UsersBloc({required this.userRepository}) : super(UsersInitial()) {
    on<LoadMyProfile>((event, emit) async {
      emit(UsersLoading());
      try {
        final user = await userRepository.getMyProfile();
        emit(UsersLoaded(user));
      } catch (e) {
        emit(UsersError("Erreur de chargement du profil."));
      }
    });
  }
}
