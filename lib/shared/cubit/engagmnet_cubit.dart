import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:socialize/models/comment_model.dart';
import 'package:socialize/models/like_model.dart';
import 'package:socialize/modules/engagment/comments_screen.dart';
import 'package:socialize/modules/engagment/likes_screen.dart';
import 'package:socialize/shared/cubit/engagment_states.dart';
import 'package:socialize/shared/network/end_points.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class EngagmentCubit extends Cubit<EngagmentStates> {
  EngagmentCubit() : super(EngagmentIntialState());

  static EngagmentCubit get(context) => BlocProvider.of(context);

  // handle Bottom Navigation Bar
  int currentIndex = 0;
  List<String> titles = [
    'Likes',
    'Comments',
  ];
  List<Widget> screens = [
    LikesScreen(),
    CommentsScreen(),
  ];
  List<GButton> bottomItems = [
    GButton(
      icon: IconBroken.Heart,
      text: 'Likes',
    ),
    GButton(
      icon: IconBroken.Chat,
      text: 'Comments',
    ),
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(EngagmentChangeBottomNavigationBarState());
  }

  // get likes
  late List<LikeModel> likes;
  void getLikes(String id) {
    likes = [];
    emit(EngagmnetGetLikesLoadingState());
    FirebaseFirestore.instance
        .collection(POSTS)
        .doc(id)
        .collection(LIKES)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        likes.add(LikeModel.fromJson(element.data()));
      });
      emit(EngagmnetGetLikesSuccessState());
    }).catchError((error) {
      emit(EngagmnetGetLikesErrorState(error.toString()));
    });
  }

  // get comments
  late List<CommentModel> comments;
  void getComments(String id) {
    comments = [];
    emit(EngagmnetGetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection(POSTS)
        .doc(id)
        .collection(COMMENTS)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(EngagmnetGetCommentsSuccessState());
    }).catchError((error) {
      emit(EngagmnetGetCommentsErrorState(error.toString()));
    });
  }
}
