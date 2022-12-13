import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/modules/login/cubit/login_states.dart';
import 'package:social_simple_app/shared/components/constants.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin(
      {required String email, required String password, required context}) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // print(value.user?.uid);
      uId = value.user?.uid;
      isFromLogin = true;
      emit(LoginSuccessState(value.user?.uid));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  bool isScure = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isScure = !isScure;
    suffix =
        isScure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityState());
  }

  // void getUserData(context) {
  //   FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
  //     print('the data form get user state ${value.data()}');
  //     HomeCubit.get(context).model = UserModel.fromJson(value.data());
  //     HomeCubit.get(context).getPosts();
  //   }).catchError((onError) {
  //     print(onError.toString());
  //     emit(LoginGetUserErrorState(onError.toString()));
  //   });
  // }
}
