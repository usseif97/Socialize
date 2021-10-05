import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/layout/engagmnet_layout.dart';
import 'package:socialize/models/post_model.dart';
import 'package:socialize/models/story_user_model.dart';
import 'package:socialize/models/user_model.dart';
import 'package:socialize/modules/post/new_post_screen.dart';
import 'package:socialize/modules/stories/data.dart';
import 'package:socialize/modules/stories/story_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/components/constants.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key}) : super(key: key);

  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeGetUserStoriesSuccessState)
          navigateTo(
            context,
            StoryScreen(stories: HomeCubit.get(context).stories),
          );
        if (state is HomeCreateNewStorySuccessState)
          showSnackBar(
            context: context,
            content: 'Story have been added successfully',
            label: 'Success',
            state: snackBarStates.SUCCESS,
          );
      },
      builder: (context, state) {
        var userModel = HomeCubit.get(context).userModel;
        var posts = HomeCubit.get(context).posts;
        var storiesUsers = HomeCubit.get(context).sortedStoriesUsers;

        return userModel != null && posts.length > 0
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Progress Indicator
                    if (state is HomeCreateNewStoryLoadingState ||
                        state is HomeStoryImageUploadSuccessState ||
                        state is HomeStoryImagePickedSuccessState)
                      LinearProgressIndicator(),
                    // Stories
                    if (storiesUsers.length > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        child: Container(
                          height: 100.0,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return _buildMyStory(context);
                              } else
                                return _buildStoryItem(
                                    storiesUsers[index - 1], context);
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 5.0),
                            itemCount: storiesUsers.length + 1,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                    //if (model!.isEmailVerified == false) verificationBuilder(context),
                    // What's in your mind ?
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage: NetworkImage(userModel.image),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigateTo(context, NewPostScreen());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'what\'s in your mind !!',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10.0,
                      margin: EdgeInsets.all(8.0),
                      child: Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-psd/city-food-billboard-mock-up_23-2149012701.jpg'),
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                    ),*/
                    // Posts
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.0),
                      itemBuilder: (context, index) => _postItemBuilder(
                        context,
                        posts[index],
                        userModel,
                        index,
                      ),
                      itemCount: posts.length,
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget _postItemBuilder(
    BuildContext context,
    PostModel model,
    UserModel userModel,
    int index,
  ) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 1.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // profile
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(model.image),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              model.name,
                              style: TextStyle(fontSize: 12.0, height: 1.4),
                            ),
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.check_circle,
                              size: 14.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Text(
                          model.date.substring(0, 16),
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 14.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              // text caption
              if (model.postText != '')
                InkWell(
                  onTap: () {
                    navigateTo(context,
                        EngagmentLayout(HomeCubit.get(context).postsId[index]));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      model.postText,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
              // hastags caption
              /*Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 3.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          child: Text(
                            '#software_engineering',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 3.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          child: Text(
                            '#flutter_development',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 3.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          minWidth: 1.0,
                          child: Text(
                            '#mobile_development',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
              // image caption
              if (model.postImage != '')
                InkWell(
                  onTap: () {
                    navigateTo(context,
                        EngagmentLayout(HomeCubit.get(context).postsId[index]));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Image(
                      image: NetworkImage(model.postImage),
                      fit: BoxFit.fill,
                      height: 200.0,
                      width: double.infinity,
                    ),
                  ),
                ),
              // engagment
              Row(
                children: [
                  // likes
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              color: Colors.pink,
                              size: 18.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              HomeCubit.get(context).likes[index].toString(),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // comments
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              color: Colors.orangeAccent,
                              size: 18.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              '${HomeCubit.get(context).comments[index]} comments',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Comments
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 10.0),
                child: defaultSeperator(),
              ),
              // interact
              Row(
                children: [
                  CircleAvatar(
                    radius: 15.0,
                    backgroundImage: NetworkImage(userModel.image),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'write a comment ...',
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (s) {
                          if (s.trim().isNotEmpty) {
                            HomeCubit.get(context).commentOnPost(
                              HomeCubit.get(context).postsId[index],
                              commentController.text,
                              index,
                            );
                            commentController.text = '';
                          }
                        },
                        controller: commentController,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      HomeCubit.get(context).likePost(
                        HomeCubit.get(context).postsId[index],
                        index,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.purple,
                          ),
                          SizedBox(width: 2.0),
                          Text(
                            'Like',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget verificationBuilder(BuildContext context) => Container(
        color: Colors.amber.withOpacity(0.6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Icon(Icons.info_outline),
              SizedBox(width: 20.0),
              Expanded(
                child: Text('Please Verify your Email !'),
              ),
              defaultTextButton(
                function: () {
                  FirebaseAuth.instance.currentUser!
                      .sendEmailVerification()
                      .then((value) {
                    showSnackBar(
                      context: context,
                      content: 'Check your Email',
                      label: '.',
                      state: snackBarStates.SUCCESS,
                    );
                  }).catchError((error) {});
                },
                text: 'Send',
              ),
            ],
          ),
        ),
      );

  Widget _buildMyStory(BuildContext context) => InkWell(
        onTap: () {
          HomeCubit.get(context).pickStoryImage();
        },
        child: Row(
          children: [
            Container(
              width: 60.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.0,
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
        ),
      );

  Widget _buildStoryItem(StoryUserModel model, BuildContext context) => InkWell(
        onTap: () {
          HomeCubit.get(context).getStoriesForUser(id: model.uID);
        },
        child: Container(
          width: 68.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    radius: 34.0,
                    backgroundColor: Colors.purple,
                  ),
                  CircleAvatar(
                    radius: 32.0,
                    backgroundColor: Colors.white,
                  ),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(model.image),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Text(
                model.name,
                style: TextStyle(fontSize: 14.0),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
