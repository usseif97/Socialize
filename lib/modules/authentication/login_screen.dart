import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/layout/home_layout.dart';
import 'package:socialize/modules/authentication/register_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/components/constants.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/login_cubit.dart';
import 'package:socialize/shared/cubit/login_states.dart';
import 'package:socialize/shared/network/local/cache_helper.dart';
import 'package:socialize/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          // Login Success
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) {
              uID = state.uid;
              print('uID: $uID');
              HomeCubit()
                ..getUserData()
                ..getPosts();
              navigateToAndFinish(context, HomeLayout());
            });
            // Login Fall
          } else if (state is LoginErrorState) {
            showSnackBar(
              context: context,
              content: state.error,
              label: 'Error',
              state: snackBarStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50.0,
                      right: 10.0,
                      left: 10.0,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: defaultColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Socialize',
                            style: TextStyle(
                              color: lightColor,
                              fontSize: 50,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 2),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              backgroundImage: NetworkImage(
                                  'https://image.freepik.com/free-vector/social-media-logotype-set_1199-178.jpg'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'login now to communicate with your friends',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                          SizedBox(height: 30),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty)
                                return 'Please Enter your Email address !!';
                            },
                            radius: 50.0,
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            context: context,
                          ),
                          SizedBox(height: 15),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value) {
                              if (value.isEmpty)
                                return 'your password is too short !!';
                            },
                            radius: 50.0,
                            isPassword: LoginCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.lock_clock_outlined,
                            context: context,
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed: () {
                              LoginCubit.get(context).changePasswordVisibilty();
                            },
                          ),
                          SizedBox(height: 30),
                          state is LoginLoadingState
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  text: 'Login',
                                  isUpperCase: true,
                                  radius: 50.0,
                                ),
                          SizedBox(height: 15),
                          Center(
                            child: Row(
                              children: [
                                Text('Don\'t have an account ?!'),
                                defaultTextButton(
                                  function: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  text: 'register',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
