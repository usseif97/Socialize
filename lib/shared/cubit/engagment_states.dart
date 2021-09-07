abstract class EngagmentStates {}

class EngagmentIntialState extends EngagmentStates {}

// Bottom Navigation Bar
class EngagmentChangeBottomNavigationBarState extends EngagmentStates {}

// Get Likes
class EngagmnetGetLikesLoadingState extends EngagmentStates {}

class EngagmnetGetLikesSuccessState extends EngagmentStates {}

class EngagmnetGetLikesErrorState extends EngagmentStates {
  final String error;
  EngagmnetGetLikesErrorState(this.error);
}

// Get Comments
class EngagmnetGetCommentsLoadingState extends EngagmentStates {}

class EngagmnetGetCommentsSuccessState extends EngagmentStates {}

class EngagmnetGetCommentsErrorState extends EngagmentStates {
  final String error;
  EngagmnetGetCommentsErrorState(this.error);
}
