import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/models/user_model.dart';
import 'package:socialize/shared/cubit/register_states.dart';
import 'package:socialize/shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterIntialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // handle Firebase Register
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      createUser(
        name: name,
        email: email,
        password: password,
        phone: phone,
        uID: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  // create new user
  void createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uID,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      password: password,
      uID: uID,
      bio: 'write your bio ..',
      image:
          'https://cdn2.vectorstock.com/i/1000x1000/59/71/purple-male-gay-bisexual-profile-picture-vector-22975971.jpg',
      cover: 'https://nanoguard.in/wp-content/uploads/2019/09/pic.jpg',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection(USERS)
        .doc(uID)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState(uID));
    }).catchError((error) {
      emit(RegisterCreateUserErrorState(error.toString()));
    });
  }

  // handle password visibilty
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangeVisibiltyState());
  }
}
