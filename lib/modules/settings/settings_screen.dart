import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/cubit/theme_cubit.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var userModel = HomeCubit.get(context).userModel;
    return Center(
      child: IconButton(
        onPressed: () {
          //ThemeCubit.get(context).changeAppMode();
        },
        icon: Icon(IconBroken.Chat),
      ),
    );
  }
}
