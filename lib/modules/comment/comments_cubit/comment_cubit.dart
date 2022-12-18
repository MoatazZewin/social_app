import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/models/user_model.dart';
import 'package:social_simple_app/modules/comment/comments_cubit/comments_states.dart';

import '../../../models/post_model.dart';

class CommentsCubit extends Cubit<CommentsStates> {
  CommentsCubit() : super(CommentsInitialState());
  static CommentsCubit get(context) => BlocProvider.of(context);
  List<CommentsModel> commentsData = [];
  List<UserModel> users = [];
  List<UserModel> usersInPost = [];
  void commentInPost(
      {required String postId,
      required String comment,
      required DateTime dateTime,
      required UserModel? user}) {
    CommentsModel model = CommentsModel(postId, comment, Timestamp.now(), user?.uId);
    usersInPost.add(user!);
    commentsData.add(model);
    emit(CommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      emit(CommentsSuccessState());
    }).catchError((error) {
      emit(CommentsErrorState());
    });
  }


  getComments({required String postId}) {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        print("the user in alll ${element.data().toString()}");
        users.add(UserModel.fromJson(element.data()));

      });

      emit(GetCommentsLoadingState());
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('dateTime')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          // print('inside the getComment method ${element.data().toString()}');
          users.forEach((user) {
            // print("the user in alll ${user}");
            if(user.uId == element.data()['userId'])
            {

              usersInPost.add(user);
              // print("the user in alll ${usersInPost[0].name}");
            }
          });
          commentsData.add(CommentsModel.fromJson(element.data()));
          emit(GetCommentsSuccessState());
        });
        emit(GetCommentsSuccessState());
      }).catchError((onError) {
        emit(GetCommentsErrorState());
      });

    }).catchError((onError){});

  }


}
