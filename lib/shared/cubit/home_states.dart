abstract class HomeStates {}

class HomeIntialState extends HomeStates {}

// Bottom Navigation Bar
class HomeChangeBottomNavigationBarState extends HomeStates {}

// New Post
class HomeNewPostState extends HomeStates {}

// Get User Data
class HomeGetUserLoadingState extends HomeStates {}

class HomeGetUserSuccessState extends HomeStates {}

class HomeGetUserErrorState extends HomeStates {
  final String error;
  HomeGetUserErrorState(this.error);
}

// Profile Image Picker
class HomeProfileImagePickedSuccessState extends HomeStates {}

class HomeProfileImagePickedErrorState extends HomeStates {
  final String error;
  HomeProfileImagePickedErrorState(this.error);
}

// Profile Image Upload
class HomeProfileImageUploadSuccessState extends HomeStates {}

class HomeProfileImageUploadErrorState extends HomeStates {
  final String error;
  HomeProfileImageUploadErrorState(this.error);
}

// Cover Image Picker
class HomeCoverImagePickedSuccessState extends HomeStates {}

class HomeCoverImagePickedErrorState extends HomeStates {
  final String error;
  HomeCoverImagePickedErrorState(this.error);
}

// Cover Image Upload
class HomeCoverImageUploadSuccessState extends HomeStates {}

class HomeCoverImageUploadErrorState extends HomeStates {
  final String error;
  HomeCoverImageUploadErrorState(this.error);
}

// Update User Data
class HomeUserUpdateLoadingState extends HomeStates {}

class HomeUserUpdateErrorState extends HomeStates {
  final String error;
  HomeUserUpdateErrorState(this.error);
}

// New Post Image Picker
class HomePostImagePickedSuccessState extends HomeStates {}

class HomePostImagePickedErrorState extends HomeStates {
  final String error;
  HomePostImagePickedErrorState(this.error);
}

// New Post Image Upload
class HomePostImageUploadSuccessState extends HomeStates {}

class HomePostImageUploadErrorState extends HomeStates {
  final String error;
  HomePostImageUploadErrorState(this.error);
}

// Create New Post
class HomeCreateNewPostLoadingState extends HomeStates {}

class HomeCreateNewPostSuccessState extends HomeStates {}

class HomeCreateNewPostErrorState extends HomeStates {
  final String error;
  HomeCreateNewPostErrorState(this.error);
}

class HomeRemovePostImageState extends HomeStates {}
