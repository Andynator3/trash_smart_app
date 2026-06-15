//import 'package:flutter_bloc/flutter_bloc.dart';
//import '../../blocs/bloc_users/users.event.dart';
//import '../../blocs/bloc_users/users.state.dart';
//import '../../repositories/user.repository.dart';


/*class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userRepository.fetchAllUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
*/