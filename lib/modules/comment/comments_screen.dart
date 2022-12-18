import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_layout.dart';
import 'package:social_simple_app/models/post_model.dart';
import 'package:social_simple_app/models/user_model.dart';
import 'package:social_simple_app/modules/comment/comments_cubit/comment_cubit.dart';
import 'package:social_simple_app/modules/comment/comments_cubit/comments_states.dart';
import 'package:social_simple_app/shared/components/components.dart';
import 'package:social_simple_app/shared/styles/colors.dart';
import 'package:social_simple_app/shared/styles/icon_broken.dart';

class CommentsScreen extends StatelessWidget {
  PostModel post;
  UserModel user;
  String postId;
  List<int> numberOfComment;
  int index;
   CommentsScreen({required this.post, required this.user, required this.postId,required this.numberOfComment, required this.index });
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> CommentsCubit()..getComments(postId: postId),
      child: BlocConsumer<CommentsCubit, CommentsStates>(
      listener: (context, state){
        // CommentsCubit.get(context).usersInPost;
        // CommentsCubit.get(context).commentsData;
      },
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            elevation: 5.0,
            leading: IconButton(
              onPressed: (){
                navigateAndFinish(context: context, widget: HomeScreen());
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            title: Text('Comments'),
            titleSpacing: 5.0,
          ),
          body:CommentsCubit.get(context).usersInPost.isEmpty?Center(child: CircularProgressIndicator()):Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(itemBuilder: (context, index){
                    return buildCommentItem(context,
                      CommentsCubit.get(context).usersInPost[index],
                        CommentsCubit.get(context).commentsData[index]);
                  },
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: CommentsCubit.get(context).commentsData.length),
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          decoration:  const InputDecoration(
                            hintText: 'Write a Comment',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      MaterialButton(onPressed: (){
                        numberOfComment[index] = ++numberOfComment[index];
                        CommentsCubit.get(context).commentInPost(postId: postId, comment: controller.text, dateTime: DateTime.now(), user: user);


                      },
                        child: Icon(IconBroken.Send,
                          color: Colors.white,),
                        minWidth: 1.0,
                        height: 50,
                        color: defaultColor,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),);
  }

  Widget buildCommentItem(context,UserModel user, CommentsModel comment)
  {
    return  Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 20.0, 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: EdgeInsets.only(
              top: 15.0,
            ),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage('${user.image}'),
            ),
          ),
          const SizedBox(width: 10.0,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width:double.infinity,
                    padding: EdgeInsets.only(left: 15.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${user.name}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize:16.0,
                          ),),
                        Text('${comment.comment}',
                          style: Theme.of(context).textTheme.bodyMedium,),
                      ],
                    ),
                  ),
                  Row(children: [
                    const SizedBox(width: 5.0,),
                    Text('${formattedDate(comment.dateTime)}',style: Theme.of(context).textTheme.caption,),
                    const SizedBox(width: 20.0,),
                    Text('Like', style: Theme.of(context).textTheme.caption),
                    const SizedBox(width: 20.0,),
                    Text('replay', style: Theme.of(context).textTheme.caption),
                  ],),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
