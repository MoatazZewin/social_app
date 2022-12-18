import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import 'likes_states.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit() : super(LikesInitial());
  static LikesCubit get(context) => BlocProvider.of(context);

  List<UserModel> list = [];
  void getUser(List<String?>? usersId) {
    emit(LikesGetLoadingUsers());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        usersId?.forEach((value) {
          if (value == element.id) {
            list?.add(UserModel.fromJson(element.data()));
          }
        });
      });
      emit(LikesGetSuccessUsers());
    });
  }
}
