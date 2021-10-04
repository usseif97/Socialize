import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialize/models/post_model.dart';
import 'package:socialize/models/user_model.dart';
import 'package:socialize/modules/post/new_post_screen.dart';
import 'package:socialize/modules/profile/edit_profile_screen.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomeCubit.get(context).userModel;
        var userPosts = HomeCubit.get(context).userPosts;
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // profile & cover Images
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
                    // name
                    Text(
                      userModel.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 5.0),
                    // bio
                    Text(
                      userModel.bio,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    // engagments
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
                                    userPosts.length.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
                                    userPosts.length.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
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
                    // add photos & edit profile
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              navigateTo(context, NewPostScreen());
                            },
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
                  ],
                ),
              ),
              if (userPosts.length > 0)
                Container(
                  padding: const EdgeInsets.all(2.0),
                  color: Colors.grey[50],
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: 1 / 1,
                    children: List.generate(
                      userPosts.length,
                      (index) => _buildGridProduct(userPosts[index], context),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridProduct(PostModel model, context) => Container(
        color: Colors.white,
        height: 100.0,
        child: Image(
          image: model.postImage == ''
              ? NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png')
              : NetworkImage(model.postImage),
          fit: BoxFit.fill,
        ),
      );
}
