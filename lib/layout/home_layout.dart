import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:socialize/modules/authentication/login_screen.dart';
import 'package:socialize/modules/post/new_post_screen.dart';
import 'package:socialize/modules/profile/profile_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/network/local/cache_helper.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        // New Post
        if (state is HomeNewPostState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPostScreen(),
            ),
          ).then((value) {
            HomeCubit.get(context).resetIndex();
          });
        }
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
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                cubit.titles[cubit.currentIndex],
                style: GoogleFonts.mcLaren(),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  //navigateTo(context, ProfileScreen());
                },
                icon: Icon(
                  IconBroken.Notification,
                ),
              ),
              IconButton(
                onPressed: () {
                  HomeCubit.get(context).userLogout();
                  //navigateTo(context, ProfileScreen());
                },
                icon: Icon(
                  IconBroken.Logout,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: GNav(
                  rippleColor: Colors.pinkAccent,
                  hoverColor: Colors.purple,
                  gap: 1,
                  activeColor: Colors.purple,
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: cubit.bottomItems,
                  selectedIndex: cubit.currentIndex,
                  onTabChange: (index) {
                    cubit.changeIndex(index);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
