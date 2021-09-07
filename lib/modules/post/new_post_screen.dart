import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/network/local/cache_helper.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var text = CacheHelper.getData(key: 'postText');

        var model = HomeCubit.get(context).userModel;
        var postImage = HomeCubit.get(context).postImage;

        var textController = TextEditingController();

        if (text != null) textController.text = text;

        return model != null
            ? Scaffold(
                appBar: AppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Create Post',
                      style: GoogleFonts.mcLaren().copyWith(fontSize: 25.0),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        if (state is HomeCreateNewPostLoadingState)
                          LinearProgressIndicator(),
                        if (state is HomeCreateNewPostLoadingState)
                          SizedBox(height: 10.0),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25.0,
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
                                        style: TextStyle(
                                            fontSize: 15.0, height: 1.4),
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
                                    'public',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(height: 1.4),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'what\'s in your mind ...',
                                border: InputBorder.none,
                              ),
                              controller: textController,
                              maxLines: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        if (postImage != null)
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 180.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  image: DecorationImage(
                                    image: FileImage(postImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.close,
                                    size: 16.0,
                                  ),
                                ),
                                onPressed: () {
                                  HomeCubit.get(context).removePostImage();
                                },
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      CacheHelper.saveData(
                                        key: 'postText',
                                        value: textController.text,
                                      ).then((value) {
                                        HomeCubit.get(context).pickPostImage();
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(IconBroken.Image),
                                        SizedBox(width: 5.0),
                                        Text('Add Photo')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      var now = DateTime.now();
                                      if (HomeCubit.get(context).postImage ==
                                          null) {
                                        HomeCubit.get(context).createPost(
                                          dateTime: now.toString(),
                                          text: textController.text,
                                        );
                                      } else {
                                        HomeCubit.get(context).uploadPostImage(
                                          dateTime: now.toString(),
                                          text: textController.text,
                                        );
                                      }
                                      showSnackBar(
                                        context: context,
                                        content: 'Post Created Successfully',
                                        label: 'Success',
                                        state: snackBarStates.SUCCESS,
                                      );
                                      CacheHelper.removeData(key: 'postText')
                                          .then((value) {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(IconBroken.Plus),
                                        SizedBox(width: 5.0),
                                        Text('Post')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
