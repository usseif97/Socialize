abstract class HomeStates {}

class HomeIntialState extends HomeStates {}

// Bottom Navigation Bar
class HomeChangeBottomNavigationBarState extends HomeStates {}

// New Post Screen
class HomeNewPostState extends HomeStates {}

// User Logout
class HomeLogoutLoadingState extends HomeStates {}

class HomeLogoutSuccessState extends HomeStates {}

class HomeLogoutErrorState extends HomeStates {
  final String error;

  HomeLogoutErrorState(this.error);
}

// Get User Data
class HomeGetUserLoadingState extends HomeStates {}

class HomeGetUserSuccessState extends HomeStates {}

class HomeGetUserErrorState extends HomeStates {
  final String error;
  HomeGetUserErrorState(this.error);
}

// Get All Users Data
class HomeGetAllUsersLoadingState extends HomeStates {}

class HomeGetAllUsersSuccessState extends HomeStates {}

class HomeGetAllUsersErrorState extends HomeStates {
  final String error;
  HomeGetAllUsersErrorState(this.error);
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

// Remove Post Image
class HomeRemovePostImageState extends HomeStates {}

// Get Posts
class HomeGetPostsLoadingState extends HomeStates {}

class HomeGetPostsSuccessState extends HomeStates {}

class HomeGetPostsErrorState extends HomeStates {
  final String error;
  HomeGetPostsErrorState(this.error);
}

// Get User Posts
class HomeGetUserPostsLoadingState extends HomeStates {}

class HomeGetUserPostsSuccessState extends HomeStates {}

class HomeGetUserPostsErrorState extends HomeStates {
  final String error;
  HomeGetUserPostsErrorState(this.error);
}

// Like Post
class HomeLikePostSuccessState extends HomeStates {}

class HomeLikePostErrorState extends HomeStates {
  final String error;
  HomeLikePostErrorState(this.error);
}

// Comment on Post
class HomeCommentPostSuccessState extends HomeStates {}

class HomeCommentPostErrorState extends HomeStates {
  final String error;
  HomeCommentPostErrorState(this.error);
}

// Send Message
class HomeSendMessageSuccessState extends HomeStates {}

class HomeSendMessageErrorState extends HomeStates {
  final String error;
  HomeSendMessageErrorState(this.error);
}

// Get All Messages
class HomeGetAllMessagesLoadingState extends HomeStates {}

class HomeGetAllMessagesSuccessState extends HomeStates {}

// Get Stories Users Data
class HomeGetStoriesUsersLoadingState extends HomeStates {}

class HomeGetStoriesUsersSuccessState extends HomeStates {}

class HomeGetStoriesUsersErrorState extends HomeStates {
  final String error;
  HomeGetStoriesUsersErrorState(this.error);
}

// Get Stories For a User Data
class HomeGetUserStoriesLoadingState extends HomeStates {}

class HomeGetUserStoriesSuccessState extends HomeStates {}

class HomeGetUserStoriesErrorState extends HomeStates {
  final String error;
  HomeGetUserStoriesErrorState(this.error);
}

// New Story Image Picker
class HomeStoryImagePickedSuccessState extends HomeStates {}

class HomeStoryImagePickedErrorState extends HomeStates {
  final String error;
  HomeStoryImagePickedErrorState(this.error);
}

// New Story Image Upload
class HomeStoryImageUploadSuccessState extends HomeStates {}

class HomeStoryImageUploadErrorState extends HomeStates {
  final String error;
  HomeStoryImageUploadErrorState(this.error);
}

// Create New Story
class HomeCreateNewStoryLoadingState extends HomeStates {}

class HomeCreateNewStorySuccessState extends HomeStates {}

class HomeCreateNewStoryErrorState extends HomeStates {
  final String error;
  HomeCreateNewStoryErrorState(this.error);
}
