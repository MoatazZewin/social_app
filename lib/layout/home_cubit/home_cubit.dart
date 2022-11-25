import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/models/user_model.dart';
import 'package:social_simple_app/modules/chats/chats_screen.dart';
import 'package:social_simple_app/modules/settings/setting_screen.dart';
import 'package:social_simple_app/modules/users/users_screen.dart';
import 'package:social_simple_app/shared/components/constants.dart';

import '../../modules/feeds/feeds_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? model;
  void getUserData() {
    emit(HomeGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print('the datat form get user state ${value.data()}');
      model = UserModel.fromJson(value.data());

      emit(HomeGetUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(HomeGetUserErrorState(onError.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];

  List<String> title = ['Home', 'Chats', 'Users', 'Settings'];

  void changeBottomNav(index) {
    if (index == 2) {
      emit(NewPostsState());
    } else {
      if (index == 3 || index == 4) {
        currentIndex = --index;
        emit(HomeChangeBottomNavState());
      } else {
        currentIndex = index;
        emit(HomeChangeBottomNavState());
      }
    }
  }

  ImagePicker picker = ImagePicker();
  XFile? profileImage;
  File? imagePath;
  Future getProfileImage() async {
    profileImage = await picker.pickImage(source: ImageSource.gallery);
    if (profileImage != null) {
      print('the path form profile image ${imagePath}');
      imagePath = File(profileImage!.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }

  XFile? coverImage;
  File? coverPath;
  Future getCoverImage() async {
    coverImage = await picker.pickImage(source: ImageSource.gallery);
    if (coverImage != null) {
      coverPath = File(coverImage!.path);
      emit(CoverImagePickedSuccessState());
    } else {
      emit(CoverImagePickedErrorState());
    }
  }

  final storage = FirebaseStorage.instance;

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());
    storage
        .ref()
        .child('users/${Uri.file(imagePath!.path).pathSegments.last}')
        .putFile(imagePath!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value);

        print('url download $p0');
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((onError) {
      emit(UploadProfileImageErrorState());
    });
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(UserUpdateLoadingState());
    storage
        .ref()
        .child('users/${Uri.file(coverPath!.path).pathSegments.last}')
        .putFile(coverPath!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value);
        print('url download $p0');
      }).catchError((error) {
        emit(UploadCoverImageErrorState());
      });
    }).catchError((onError) {
      emit(UploadCoverImageErrorState());
    });
  }
  //
  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(UserUpdateLoadingState());
  //   if (imagePath != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (imagePath != null && coverImage != null) {
  //     uploadProfileImage();
  //     uploadCoverImage();
  //   } else {
  //
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel userModel = UserModel(
        name: name,
        phone: phone,
        image: image??model?.image,
        bio: bio,
        cover:cover?? model?.cover,
        uId: model?.uId,
        email: model?.email,
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      emit(UserUpdateErrorState());
    });
  }
}
