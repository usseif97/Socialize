abstract class HomeStates {}

class HomeIntialState extends HomeStates {}

class HomeChangeBottomNavigationBarState extends HomeStates {}

class HomeNewPostState extends HomeStates {}

class HomeGetUserLoadingState extends HomeStates {}

class HomeGetUserSuccessState extends HomeStates {}

class HomeGetUserErrorState extends HomeStates {
  final String error;
  HomeGetUserErrorState(this.error);
}
