import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/shared/cubit/logout_states.dart';

class LogoutCubit extends Cubit<LogoutStates> {
  LogoutCubit() : super(LogoutIntialState());

  static LogoutCubit get(context) => BlocProvider.of(context);

  // handle Firebase Logout
  void userLogout() {
    emit(LogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LogoutErrorState(error.toString()));
    });
  }
}
