import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_cubit/home_cubit.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/models/user_model.dart';
import 'package:social_simple_app/modules/chat_details/chat_details.dart';
import 'package:social_simple_app/shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>( listener: (context, state){},
    builder: (context, state){
      return HomeCubit.get(context).users.isNotEmpty ? ListView.separated(
        physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index)=> buildIChatItem(HomeCubit.get(context).users[index], context) ,
          separatorBuilder: (context, index)=> myDivider(),
          itemCount: HomeCubit.get(context).users.length):const Center(child: CircularProgressIndicator()) ;
    },);
  }

  Widget buildIChatItem(UserModel model , context) => InkWell(
    onTap: (){
      navigateTo(context: context, widget: ChatDetailsScreen(model:model));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}
