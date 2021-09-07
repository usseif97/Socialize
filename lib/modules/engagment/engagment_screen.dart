import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/shared/cubit/engagment_states.dart';
import 'package:socialize/shared/cubit/engagmnet_cubit.dart';

class EngagmentScreen extends StatelessWidget {
  const EngagmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EngagmentCubit, EngagmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: null,
        );
      },
    );
  }
}
