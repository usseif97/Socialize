abstract class RegisterStates {}

class RegisterIntialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class RegisterCreateUserSuccessState extends RegisterStates {
  final String uid;
  RegisterCreateUserSuccessState(this.uid);
}

class RegisterCreateUserErrorState extends RegisterStates {
  final String error;
  RegisterCreateUserErrorState(this.error);
}

class RegisterChangeVisibiltyState extends RegisterStates {}
