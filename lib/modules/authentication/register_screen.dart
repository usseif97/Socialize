import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/layout/home_layout.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/components/constants.dart';
import 'package:socialize/shared/cubit/register_cubit.dart';
import 'package:socialize/shared/cubit/register_states.dart';
import 'package:socialize/shared/network/local/cache_helper.dart';
import 'package:socialize/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          // Register Success
          if (state is RegisterCreateUserSuccessState) {
            CacheHelper.saveData(
              key: 'uid',
              value: state.uid,
            ).then((value) {
              uID = state.uid;
              navigateToAndFinish(context, HomeLayout());
            });
            // Register Fall
          } else if (state is RegisterCreateUserErrorState) {
            showSnackBar(
              context: context,
              content: 'Network Error !!',
              label: 'Error',
              state: snackBarStates.ERROR,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: defaultColor),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarBrightness: Brightness.dark,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Register now to find new frineds',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your name';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                          context: context,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          context: context,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: RegisterCubit.get(context).suffix,
                          onSubmit: (value) {},
                          isPassword: RegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            RegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          context: context,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'please enter your phone number';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                          context: context,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        state is RegisterLoadingState
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'register',
                                isUpperCase: true,
                                radius: 50.0,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
