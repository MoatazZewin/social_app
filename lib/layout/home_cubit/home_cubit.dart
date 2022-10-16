import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      print(model);
      model = UserModel.fromJson(value.data());
      print(value.data());
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
      if(index == 3 || index == 4)
        {
          currentIndex = --index ;
          emit(HomeChangeBottomNavState());
        }else{
        currentIndex = index;
        emit(HomeChangeBottomNavState());
      }

    }
  }
}
