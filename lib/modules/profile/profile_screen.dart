import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialize/modules/authentication/login_screen.dart';
import 'package:socialize/modules/profile/edit_profile_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/network/local/cache_helper.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // Logout Success
        if (state is HomeLogoutSuccessState) {
          CacheHelper.removeData(
            key: 'uid',
          ).then((value) {
            navigateToAndFinish(context, LoginScreen());
          });
          // Logout Fall
        } else if (state is HomeLogoutErrorState) {
          showSnackBar(
            context: context,
            content: state.error,
            label: 'Error',
            state: snackBarStates.ERROR,
          );
        }
      },
      builder: (context, state) {
        var userModel = HomeCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                'Profile',
                style: GoogleFonts.mcLaren().copyWith(fontSize: 25.0),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 180.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(userModel!.cover),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 51.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(userModel.image),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  userModel.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 5.0),
                Text(
                  userModel.bio,
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '200',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '5k',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                '109',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Following',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          'Add Photos',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 16.0,
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {
                    HomeCubit.get(context).userLogout();
                  },
                  child: Text(
                    'Log Out',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
