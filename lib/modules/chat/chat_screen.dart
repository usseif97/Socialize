import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/models/user_model.dart';
import 'package:socialize/modules/chat/chatting_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/styles/colors.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Search
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200],
                            ),
                            child: Row(
                              children: [
                                Icon(IconBroken.Search),
                                SizedBox(width: 10),
                                Text('Search'),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.0),
                          // Story
                          Container(
                            height: 90.0,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index == 0)
                                  return _buildMyStory();
                                else
                                  return _buildStoryItem(usersList[index - 1]);
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 5.0),
                              itemCount: usersList.length + 1,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          // Chat
                          ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                _buildChatItem(usersList[index], context),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.0),
                            itemCount: usersList.length,
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Text('No Users !!'),
                  );
      },
    );
  }

  Widget _buildMyStory() => Row(
        children: [
          Container(
            width: 40.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  child: Icon(IconBroken.Plus),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Add Your Story',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 10.0),
        ],
      );

  Widget _buildStoryItem(UserModel model) => Container(
        width: 60.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(model.image),
                ),
                CircleAvatar(
                  radius: 7.0,
                  backgroundColor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 3.0,
                    end: 3.0,
                  ),
                  child: CircleAvatar(
                    radius: 5.0,
                    backgroundColor:
                        model.isOnline ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Text(
              model.name,
              style: TextStyle(fontSize: 14.0),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );

  Widget _buildChatItem(UserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
            context,
            ChattingScreen(userModel: model),
          );
        },
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(model.image),
                ),
                CircleAvatar(
                  radius: 5.5,
                  backgroundColor: Colors.white,
                ),
                CircleAvatar(
                  radius: 5.0,
                  backgroundColor: model.isOnline ? Colors.green : Colors.grey,
                ),
              ],
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.bio,
                          style: Theme.of(context).textTheme.caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 5.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: defaultColor,
                          ),
                        ),
                      ),
                      //Text('02:00 pm'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
