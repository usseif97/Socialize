import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:socialize/shared/cubit/engagment_states.dart';
import 'package:socialize/shared/cubit/engagmnet_cubit.dart';

class EngagmentLayout extends StatelessWidget {
  final postId;
  EngagmentLayout(this.postId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EngagmentCubit()
        ..getLikes(postId)
        ..getComments(postId),
      child: BlocConsumer<EngagmentCubit, EngagmentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = EngagmentCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  cubit.titles[cubit.currentIndex],
                  style: GoogleFonts.mcLaren(),
                ),
              ),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  child: GNav(
                    rippleColor: Colors.pinkAccent,
                    hoverColor: Colors.purple,
                    gap: 8,
                    activeColor: Colors.purple,
                    iconSize: 20,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
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
      ),
    );
  }
}
