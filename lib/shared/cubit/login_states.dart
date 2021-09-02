//import 'package:souq/models/login_model.dart';

abstract class LoginStates {}

class LoginIntialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangeVisibiltyState extends LoginStates {}
