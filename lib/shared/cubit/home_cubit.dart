import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:socialize/models/user_model.dart';
import 'package:socialize/modules/chat/chat_screen.dart';
import 'package:socialize/modules/feeds/feeds_screen.dart';
import 'package:socialize/modules/post/new_post_screen.dart';
import 'package:socialize/modules/settings/settings_screen.dart';
import 'package:socialize/modules/users/users_screen.dart';
import 'package:socialize/shared/components/constants.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/network/end_points.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titles = [
    'New Feed',
    'Chat',
    'New Post',
    'Friends',
    'Settings',
  ];
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<GButton> bottomItems = [
    GButton(
      icon: IconBroken.Home,
      text: 'Home',
    ),
    GButton(
      icon: IconBroken.Chat,
      text: 'Chat',
    ),
    GButton(
      icon: IconBroken.Paper_Upload,
      text: 'Post',
    ),
    GButton(
      icon: IconBroken.User,
      text: 'Users',
    ),
    GButton(
      icon: IconBroken.Setting,
      text: 'Settings',
    ),
  ];
  void changeIndex(int index) {
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

  // Get User Data
  UserModel? userModel;
  void getUserData() {
    emit(HomeGetUserLoadingState());
    FirebaseFirestore.instance.collection(USERS).doc(uID).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      emit(HomeGetUserSuccessState());
    }).catchError((error) {
      emit(HomeGetUserErrorState(error.toString()));
    });
  }
}
