import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/models/user_model.dart';
import 'package:socialize/modules/profile/profile_screen.dart';
import 'package:socialize/modules/users/user_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/styles/colors.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var usersList = HomeCubit.get(context).allUsers;
        return state is HomeGetAllUsersLoadingState
            ? Center(
                child: CircularProgressIndicator(),
              )
            : usersList.length > 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          _buildUserItem(usersList[index], context),
                      separatorBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(height: 15.0),
                            defaultSeperator(),
                            SizedBox(height: 15.0),
                          ],
                        );
                      },
                      itemCount: usersList.length,
                    ),
                  )
                : Center(
                    child: Text('No Users !!'),
                  );
      },
    );
  }

  Widget _buildUserItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            UserScreen(userModel: model),
          );
          HomeCubit.get(context).getUserPosts(model.uID);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(model.image),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.bio,
                    style: Theme.of(context).textTheme.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
