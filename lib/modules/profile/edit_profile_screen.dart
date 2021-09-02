import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialize/shared/components/components.dart';
import 'package:socialize/shared/cubit/home_cubit.dart';
import 'package:socialize/shared/cubit/home_states.dart';
import 'package:socialize/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomeCubit.get(context).userModel;
        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;

        nameController.text = userModel!.name;
        bioController.text = userModel.bio;
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                'Edit Profile',
                style: GoogleFonts.mcLaren().copyWith(fontSize: 25.0),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is HomeUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is HomeUserUpdateLoadingState)
                    SizedBox(height: 10.0),
                  Container(
                    height: 180.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null
                                        ? NetworkImage(userModel.cover)
                                        : FileImage(coverImage)
                                            as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  HomeCubit.get(context).pickCoverImage();
                                },
                                icon: CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(IconBroken.Camera),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 51.0,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(userModel.image)
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                HomeCubit.get(context).pickProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 12.0,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 15.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) return 'name can\'t be empty !!';
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                    context: context,
                  ),
                  SizedBox(height: 10.0),
                  defaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) return 'bio can\'t be empty !!';
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                    context: context,
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          HomeCubit.get(context).updateUser(
                            name: nameController.text,
                            bio: bioController.text,
                          );
                        },
                        child: Text(
                          'Update',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
