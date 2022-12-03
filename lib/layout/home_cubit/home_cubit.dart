import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/models/message_model.dart';
import 'package:social_simple_app/models/post_model.dart';
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
      model = UserModel.fromJson(value.data());
      print('the data form get user state ${value.data()}');
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
        if (index == 1) {
          getUsers();
        }
        // if(index == 0)
        //   {
        //     getUserData();
        //   }
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

  XFile? postImage;
  File? postPath;
  Future getPostImage() async {
    postImage = await picker.pickImage(source: ImageSource.gallery);
    if (postImage != null) {
      postPath = File(postImage!.path);
      emit(UploadPostImageSuccessState());
    } else {
      emit(UploadPostImageErrorState());
    }
  }

  void removePostImage() {
    postPath = null;
    emit(RemovePostImageState());
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

  void uploadPostImage({
    required String dataTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    storage
        .ref()
        .child('posts/${Uri.file(postPath!.path).pathSegments.last}')
        .putFile(postPath!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        print('url download $p0');
        createPost(dataTime: dataTime, text: text, postImage: value);
      }).catchError((error) {
        emit(UploadPostImageErrorState());
      });
    }).catchError((onError) {
      emit(UploadPostImageErrorState());
    });
  }

  void createPost({
    required String dataTime,
    required String text,
    String? postImage,
  }) {
    PostModel userModel = PostModel(
        name: model?.name,
        image: model?.image,
        uId: model?.uId,
        dateTime: dataTime,
        text: text,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(userModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((onError) {
      emit(CreatePostErrorState());
    });
  }

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
        image: image ?? model?.image,
        bio: bio,
        cover: cover ?? model?.cover,
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

  List<PostModel> posts = [];
  List<String> postIds = [];
  List<int> likes = [];

  // void getLikes()
  // {
  //   FirebaseFirestore.instance.collection('posts').get().then((value) {
  //     for (var element in value.docs) {
  //       element.reference.collection('likes').get().then((value) {
  //         likes.add(value.docs.length);
  //       });
  //
  //     }
  //     emit(GetLikesSuccessState());
  //   }).catchError((error){
  //     emit(GetLikesErrorState());
  //   });
  // }

  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postIds.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(GetPostsSuccessState());
        }).catchError((onError) {});
      }
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model?.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];
  void getUsers() {
    if (users.isEmpty) {
      emit(HomeGetAllUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != model?.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }
        emit(HomeGetAllUsersSuccessState());
      }).catchError((error) {
        emit(HomeGetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage(
      {required String text,
      required String dateTime,
      required String? receiverId}) {
    MessageModel messageModel = MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: model?.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel!.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model?.uId)
        .collection('message')
        .add(messageModel!.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messageList = [];

  void getMessages({required String? receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messageList = [];
      event.docs.forEach((element) {
        print(element.data().toString());
        messageList.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });


  }
}
