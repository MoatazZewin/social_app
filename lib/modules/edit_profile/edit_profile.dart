import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_cubit/home_cubit.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/shared/components/components.dart';

import '../../shared/styles/icon_broken.dart';

class EditProfile extends StatelessWidget {
  var nameEditController = TextEditingController();
  var bioEditController = TextEditingController();
  var phoneEditController = TextEditingController();
  ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          var userModel = HomeCubit.get(context).model;
          File? imageFile = HomeCubit.get(context).imagePath;
          File? coverFile = HomeCubit.get(context).coverPath;

          nameEditController.text = userModel!.name!;
          bioEditController.text = userModel!.bio!;
          phoneEditController.text = userModel!.phone!;

          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',
              actions: [
                TextButton(
                  onPressed: () {
                    HomeCubit.get(context).updateUser(name: nameEditController.text, phone: phoneEditController.text, bio: bioEditController.text);
                  },
                  child: const Text('UPDATE'),
                ),
                const SizedBox(
                  width: 15.0,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if(state is UserUpdateLoadingState)
                    const LinearProgressIndicator(),
                    if(state is UserUpdateLoadingState)
                    const SizedBox(height: 10.0,),
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4.0),
                                      topRight: Radius.circular(4.0),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: coverFile == null
                                          ? NetworkImage('${userModel?.cover}')
                                          : FileImage(coverFile) as ImageProvider,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).getCoverImage();
                                    },
                                    icon: const CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(
                                        IconBroken.Camera,
                                        size: 16.0,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: imageFile == null
                                      ? NetworkImage('${userModel?.image}')
                                      : FileImage(imageFile!) as ImageProvider,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).getProfileImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 16.0,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if(imageFile != null || coverFile != null)
                    Row(
                      children: [
                        if(coverFile != null)
                        Expanded(child: defaultButton(text: 'UPLOAD COVER', onPressed: (){
                          HomeCubit.get(context).uploadCoverImage(name: nameEditController.text, phone: phoneEditController.text, bio: bioEditController.text);
                        })),
                        const SizedBox(width: 5,),
                        if(imageFile != null)
                        Expanded(child: defaultButton(text: 'UPLOAD PROFILE', onPressed: (){
                          HomeCubit.get(context).uploadProfileImage(name: nameEditController.text, phone: phoneEditController.text, bio: bioEditController.text);
                        })),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultTextFromField(
                        label: 'Name',
                        prefixIcon: IconBroken.User,
                        controller: nameEditController,
                        textInputType: TextInputType.name,
                        validatorMethod: (value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultTextFromField(
                        label: 'Bio',
                        prefixIcon: IconBroken.Info_Circle,
                        controller: bioEditController,
                        textInputType: TextInputType.text,
                        validatorMethod: (value) {
                          if (value!.isEmpty) {
                            return 'bio must not be empty';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultTextFromField(
                        label: 'Phone',
                        prefixIcon: IconBroken.Call,
                        controller: phoneEditController,
                        textInputType: TextInputType.phone,
                        validatorMethod: (value) {
                          if (value!.isEmpty) {
                            return 'Phone must not be empty';
                          }
                          return null;
                        }),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
