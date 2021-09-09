//import 'package:souq/models/login_model.dart';

abstract class LogoutStates {}

class LogoutIntialState extends LogoutStates {}

class LogoutLoadingState extends LogoutStates {}

class LogoutSuccessState extends LogoutStates {
  LogoutSuccessState();
}

class LogoutErrorState extends LogoutStates {
  final String error;

  LogoutErrorState(this.error);
}
