import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/models/post_model.dart';
import 'package:social_simple_app/models/user_model.dart';
import 'package:social_simple_app/modules/likes/likes_cubit/likes_cubit.dart';
import 'package:social_simple_app/modules/likes/likes_cubit/likes_states.dart';
import 'package:social_simple_app/shared/components/components.dart';

class LikesScreen extends StatelessWidget {
   PostModel model;
   LikesScreen({required this.model}) ;
   // HomeCubit.get(context).users[0];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LikesCubit()..getUser(model.likes),
    child: BlocConsumer<LikesCubit, LikesState>(
      listener: (context, state){},
      builder: (context, state){

        return  Scaffold(
          appBar: defaultAppBar(context: context, title: 'Likes',elevation:  5.0),
          body: ListView.separated(itemBuilder: (context, index){
            // UserModel? user = HomeCubit.get(context).users[0];
            // HomeCubit.get(context).users.forEach((element) {
            //    if (element.uId == model.likes![index]){
            //      print("inside if ${element.uId}");
            //      user = element;
            //    }
            // });
            return buildIChatItem(LikesCubit.get(context).list![index] , context);
          }, separatorBuilder: (context, index){
            return myDivider();
          },
              itemCount: LikesCubit.get(context).list.length),
        );
      },
    ),);
  }

  Widget buildIChatItem(UserModel? model, context) => InkWell(
    onTap: () {
      // navigateTo(context: context, widget: ChatDetailsScreen(model: model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage('${model?.image}'),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${model?.name}',
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
