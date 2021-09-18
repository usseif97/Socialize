import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:socialize/models/comment_model.dart';
import 'package:socialize/models/like_model.dart';
import 'package:socialize/modules/engagment/comments_screen.dart';
import 'package:socialize/modules/engagment/likes_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/cloud_messaging_states.dart';
import 'package:socialize/shared/cubit/engagment_states.dart';
import 'package:socialize/shared/network/end_points.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class CloudMessagingCubit extends Cubit<CloudMessagingStates> {
  CloudMessagingCubit() : super(CloudMessagingIntialState());

  static CloudMessagingCubit get(context) => BlocProvider.of(context);

  // foreground fcm
  void foregroundFCM(context) {
    FirebaseMessaging.onMessage.listen((event) {
      print('on message');
      print(event.data.toString());
      showSnackBar(
        context: context,
        content: 'Sucess',
        label: 'on message',
        state: snackBarStates.SUCCESS,
      );
    });
  }

  // when click on notification to open app
  void openAppFCM(context) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('on message opened app');
      print(event.data.toString());
      showSnackBar(
        context: context,
        content: 'Sucess',
        label: 'on message opened app',
        state: snackBarStates.SUCCESS,
      );
    });
  }

  // background fcm
  void backroundFCM() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('on background message');
    print(message.data.toString());
    //showSnackBar(context: context, content: 'Sucess', label:  'on background message', state: snackBarStates.SUCCESS,);
  }

  //API: https://fcm.googleapis.com/fcm/send
}
