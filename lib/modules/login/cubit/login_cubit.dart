import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/modules/login/cubit/login_states.dart';
import 'package:social_simple_app/shared/components/constants.dart';
import 'package:social_simple_app/shared/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password).then((value) {
          print(value.user?.uid);
          emit(LoginSuccessState(value.user?.uid));
    }).catchError((onError){
      emit(LoginErrorState(onError.toString()));
    });
  }

  bool isScure = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isScure = !isScure;
    suffix =
        isScure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginPasswordVisibilityState());
  }
}
