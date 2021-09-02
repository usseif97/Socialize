import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialize/modules/post/new_post_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = HomeCubit.get(context).userModel;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          //if (model!.isEmailVerified == false) verificationBuilder(context),
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
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/beautiful-smiling-girl-introduce-something-holding-hand_1258-19078.jpg'),
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
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
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
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: 10.0),
            itemBuilder: (context, index) => _postItemBuilder(context),
            itemCount: 10,
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Widget _postItemBuilder(BuildContext context) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // profile
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/beautiful-smiling-girl-introduce-something-holding-hand_1258-19078.jpg'),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Usseif Ahmed',
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
                          'January 21, 2021 at 12:00 am',
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
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              // hastags caption
              Container(
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
              ),
              // image caption
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5.0,
                margin: EdgeInsets.all(8.0),
                child: Image(
                  image: NetworkImage(
                      'https://image.freepik.com/free-psd/city-food-billboard-mock-up_23-2149012701.jpg'),
                  fit: BoxFit.cover,
                  height: 120.0,
                  width: double.infinity,
                ),
              ),
              // engagment
              Row(
                children: [
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
                              '120',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                              '521 comments',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 10.0),
                child: defaultSeperator(),
              ),
              // interact
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundImage: NetworkImage(
                                'https://image.freepik.com/free-photo/beautiful-smiling-girl-introduce-something-holding-hand_1258-19078.jpg'),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'write a comment ...',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
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
}
