import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialize/models/comment_model.dart';
import 'package:socialize/models/like_model.dart';
import 'package:socialize/models/message_model.dart';
import 'package:socialize/models/post_model.dart';
import 'package:socialize/models/user_model.dart';
import 'package:socialize/modules/chat/chat_screen.dart';
import 'package:socialize/modules/feeds/feeds_screen.dart';
import 'package:socialize/modules/post/new_post_screen.dart';
import 'package:socialize/modules/profile/profile_screen.dart';
import 'package:socialize/modules/settings/settings_screen.dart';
import 'package:socialize/modules/users/users_screen.dart';
import 'package:socialize/shared/components/constants.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/network/end_points.dart';
import 'package:socialize/shared/styles/icon_broken.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  // handle Bottom Navigation Bar
  int currentIndex = 0;
  List<String> titles = [
    'New Feed',
    'Friends',
    'New Post',
    'Chat',
    'Profile',
  ];
  List<Widget> screens = [
    FeedsScreen(),
    UsersScreen(),
    NewPostScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  List<GButton> bottomItems = [
    GButton(
      icon: IconBroken.Home,
      text: 'Home',
    ),
    GButton(
      icon: IconBroken.User,
      text: 'Users',
    ),
    GButton(
      icon: IconBroken.Plus,
      text: 'Post',
    ),
    GButton(
      icon: IconBroken.Chat,
      text: 'Chat',
    ),
    GButton(
      icon: IconBroken.Profile,
      text: 'Profile',
    ),
  ];
  void changeIndex(int index) {
    if (index == 1) getAllUsers();
    if (index == 3) getAllUsers();
    if (index == 4) getUserPosts();
    if (index == 2)
      emit(HomeNewPostState());
    else {
      currentIndex = index;
      emit(HomeChangeBottomNavigationBarState());
    }
  }

  void resetIndex() {
    currentIndex = 0;
    emit(HomeChangeBottomNavigationBarState());
  }

  // handle Firebase Logout
  void userLogout() {
    emit(HomeLogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      UserModel model = UserModel(
        name: userModel!.name,
        bio: userModel!.bio,
        phone: userModel!.phone,
        password: userModel!.password,
        email: userModel!.email,
        cover: userModel!.cover,
        image: userModel!.image,
        uID: userModel!.uID,
        isOnline: false,
        isEmailVerified: false,
      );
      FirebaseFirestore.instance
          .collection(USERS)
          .doc(uID)
          .update(model.toMap())
          .then((value) {})
          .catchError((error) {
        emit(HomeUserUpdateErrorState(error.toString()));
      });

      emit(HomeLogoutSuccessState());
    }).catchError((error) {
      emit(HomeLogoutErrorState(error.toString()));
    });
  }

  // Get User Data
  UserModel? userModel;
  void getUserData() {
    emit(HomeGetUserLoadingState());
    //print('uID: $uID');
    FirebaseFirestore.instance.collection(USERS).doc(uID).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      userModel!.isOnline = true;
      FirebaseFirestore.instance
          .collection(USERS)
          .doc(uID)
          .update(userModel!.toMap())
          .then((value) {
        emit(HomeGetUserSuccessState());
      }).catchError((error) {
        emit(HomeUserUpdateErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(HomeGetUserErrorState(error.toString()));
    });
  }

  // handle profile image picker
  File? profileImage;
  var picker = ImagePicker();
  Future<void> pickProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(HomeProfileImagePickedSuccessState());
    } else {
      print('No image seleced !!');
      emit(HomeProfileImagePickedErrorState('error'));
    }
  }

  // handle cover image picker
  File? coverImage;
  Future<void> pickCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(HomeCoverImagePickedSuccessState());
    } else {
      print('No image seleced !!');
      emit(HomeCoverImagePickedErrorState('error'));
    }
  }

  // upload profile image
  String profileImageURL = '';
  void uploadProfileImage({
    required String name,
    required String bio,
  }) {
    var imagePath = Uri.file(profileImage!.path).pathSegments.last;
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/$imagePath')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageURL = value;
        updateUserData(
          name: name,
          bio: bio,
          image: profileImageURL,
        );
        emit(HomeProfileImageUploadSuccessState());
      }).catchError((error) {
        emit(HomeProfileImageUploadErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(HomeProfileImageUploadErrorState(error.toString()));
    });
  }

  // upload cover image
  String coverImageURL = '';
  void uploadCoverImage({
    required String name,
    required String bio,
  }) {
    var imagePath = Uri.file(coverImage!.path).pathSegments.last;
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/$imagePath')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageURL = value;
        updateUserData(
          name: name,
          bio: bio,
          cover: coverImageURL,
        );
        emit(HomeCoverImageUploadSuccessState());
      }).catchError((error) {
        emit(HomeCoverImageUploadErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(HomeCoverImageUploadErrorState(error.toString()));
    });
  }

  // update User Conditions (on pressed event)
  void updateUser({
    required String name,
    required String bio,
  }) {
    emit(HomeUserUpdateLoadingState());
    if (profileImage != null) uploadProfileImage(name: name, bio: bio);

    if (coverImage != null) uploadCoverImage(name: name, bio: bio);

    if (profileImage == null && coverImage == null) {
      updateUserData(
        name: name,
        bio: bio,
      );
    }
  }

  // update User Data in Firebase
  void updateUserData({
    required String name,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel model = UserModel(
      name: name,
      bio: bio,
      phone: userModel!.phone,
      password: userModel!.password,
      email: userModel!.email,
      cover: cover != null ? cover : userModel!.cover,
      image: image != null ? image : userModel!.image,
      uID: userModel!.uID,
      isOnline: userModel!.isOnline,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection(USERS)
        .doc(uID)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(HomeUserUpdateErrorState(error.toString()));
    });
  }

  // handle new post image picker
  File? postImage;
  Future<void> pickPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(HomePostImagePickedSuccessState());
    } else {
      print('No image seleced !!');
      emit(HomePostImagePickedErrorState('error'));
    }
  }

  // handle new post image upload
  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    var imagePath = Uri.file(postImage!.path).pathSegments.last;
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/$imagePath')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(HomePostImageUploadSuccessState());
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
        removePostImage();
        //getPosts();
      }).catchError((error) {
        emit(HomePostImageUploadErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(HomePostImageUploadErrorState(error.toString()));
    });
  }

  void removePostImage() {
    postImage = null;
    emit(HomeRemovePostImageState());
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(HomeCreateNewPostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uID: userModel!.uID,
      date: dateTime,
      postText: text,
      postImage: postImage != null ? postImage : '',
    );

    FirebaseFirestore.instance
        .collection(POSTS)
        .add(model.toMap())
        .then((value) {
      getPosts();
      emit(HomeCreateNewPostSuccessState());
    }).catchError((error) {
      emit(HomeCreateNewPostErrorState(error.toString()));
    });
  }

  // get all Posts with likes & comments
  late List<PostModel> posts;
  late List<String> postsId;
  late List<int> likes;
  late List<int> comments;
  void getPosts() {
    posts = [];
    postsId = [];
    likes = [];
    comments = [];
    emit(HomeGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection(POSTS)
        //.orderBy('date')
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        var elementLikes = await element.reference.collection(LIKES).get();
        var elementComments =
            await element.reference.collection(COMMENTS).get();
        likes.add(elementLikes.docs.length);
        comments.add(elementComments.docs.length);
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      });
      await Future.delayed(const Duration(seconds: 3), () {
        emit(HomeGetPostsSuccessState());
      });
    }).catchError((error) {
      emit(HomeGetPostsErrorState(error.toString()));
    });
  }

  // get the user posts only
  late List<PostModel> userPosts;
  void getUserPosts() {
    userPosts = [];
    emit(HomeGetUserPostsLoadingState());
    FirebaseFirestore.instance
        .collection(POSTS)
        .where('uID', isEqualTo: uID)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userPosts.add(PostModel.fromJson(element.data()));
      });
      emit(HomeGetUserPostsSuccessState());
    }).catchError((error) {
      emit(HomeGetUserPostsErrorState(error.toString()));
    });
  }

  // handling like Post
  void likePost(String postID, int index) {
    LikeModel model = LikeModel(
      name: userModel!.name,
      image: userModel!.image,
      uID: userModel!.uID,
      like: true,
    );
    FirebaseFirestore.instance
        .collection(POSTS)
        .doc(postID)
        .collection(LIKES)
        .doc(userModel!.uID)
        .set(model.toMap())
        .then((value) {
      likes[index]++;
      emit(HomeLikePostSuccessState());
    }).catchError((error) {
      emit(HomeLikePostErrorState(error.toString()));
    });
  }

  // handling comment on Post
  void commentOnPost(String postID, String comment, int index) {
    CommentModel model = CommentModel(
      name: userModel!.name,
      image: userModel!.image,
      uID: userModel!.uID,
      comment: comment,
    );
    FirebaseFirestore.instance
        .collection(POSTS)
        .doc(postID)
        .collection(COMMENTS)
        .add(model.toMap())
        .then((value) {
      comments[index]++;
      emit(HomeCommentPostSuccessState());
    }).catchError((error) {
      emit(HomeCommentPostErrorState(error.toString()));
    });
  }

  // Get all users
  late List<UserModel> allUsers = [];
  void getAllUsers() {
    if (allUsers.length == 0) {
      emit(HomeGetAllUsersLoadingState());
      FirebaseFirestore.instance.collection(USERS).get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uID'] != userModel!.uID)
            allUsers.add(UserModel.fromJson(element.data()));
        });
        emit(HomeGetAllUsersSuccessState());
      }).catchError((error) {
        emit(HomeGetAllUsersErrorState(error.toString()));
      });
    }
  }

  // Send Message
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uID,
      receiverID: receiverId,
      dateTime: dateTime,
    );

    // set my chat
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(userModel!.uID)
        .collection(CHATS)
        .doc(receiverId)
        .collection(MESSAGES)
        .add(model.toMap())
        .then((value) {
      emit(HomeSendMessageSuccessState());
    }).catchError((error) {
      emit(HomeSendMessageErrorState(error.toString()));
    });

    // set receiver chat
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(receiverId)
        .collection(CHATS)
        .doc(userModel!.uID)
        .collection(MESSAGES)
        .add(model.toMap())
        .then((value) {
      emit(HomeSendMessageSuccessState());
    }).catchError((error) {
      emit(HomeSendMessageErrorState(error.toString()));
    });
  }

  // Get all Messages
  List<MessageModel> messages = [];
  void getMessages({
    required String receiverId,
  }) {
    emit(HomeGetAllMessagesLoadingState());
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(userModel!.uID)
        .collection(CHATS)
        .doc(receiverId)
        .collection(MESSAGES)
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(HomeGetAllMessagesSuccessState());
    });
  }
}
