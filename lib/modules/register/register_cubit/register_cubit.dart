import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/models/user_model.dart';
import 'package:social_simple_app/modules/register/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isObscure = true;
  IconData icon = Icons.visibility;

  void changePasswordVisibility() {
    isObscure = !isObscure;
    icon = isObscure ? Icons.visibility : Icons.visibility_off;
    emit(RegisterPasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
   FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password)
       .then((value){
         print(value.user?.email);
         print(value.user?.uid);
         createUser(name: name, email: email, phone: phone, uId: value.user!.uid);

   })
       .catchError((onError)
   {
     print(onError.toString());
     emit(RegisterErrorState(onError.toString()));
   });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){
    UserModel userModel = UserModel(name, email, phone, uId);

    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap())
        .then((value){
          emit(CreateUserSuccessState());

    }).catchError((onError){
      print(onError.toString());
      emit(CreateUserErrorState(onError.toString()));

    });


  }
}
