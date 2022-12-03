import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_cubit/home_cubit.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/models/user_model.dart';
import 'package:social_simple_app/shared/styles/colors.dart';
import 'package:social_simple_app/shared/styles/icon_broken.dart';

import '../../shared/components/constants.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel? model;
  ChatDetailsScreen({this.model});
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      HomeCubit.get(context).getMessages(receiverId: model?.uId);
      return BlocConsumer<HomeCubit, HomeStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${model?.image}'),
                    ),
                    const SizedBox(
                      width: 10.0,
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
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            if(HomeCubit.get(context).messageList[index].senderId == uId ) {
                              return buildMyMessage(HomeCubit.get(context).messageList[index].text);
                            }
                            return buildMessage(HomeCubit.get(context).messageList[index].text);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 15.0,
                              ),
                          itemCount: HomeCubit.get(context).messageList.length),
                    ),
                    // Spacer(),
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
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here....',
                              ),
                            ),
                          ),
                          Container(
                            color: defaultColor,
                            height: 50.0,
                            child: MaterialButton(
                              onPressed: () {
                                HomeCubit.get(context).sendMessage(
                                    text: controller.text,
                                    dateTime: DateTime.now().toString(),
                                    receiverId: model?.uId);
                                controller.text = '';
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                IconBroken.Send,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {});
    });
  }

  Widget buildMessage(String? message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:  const BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                bottomEnd: Radius.circular(10.0),
              ),
            ),
            child:  Text(message!)),
      );
  Widget buildMyMessage(String? message) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                bottomStart: Radius.circular(10.0),
              ),
            ),
            child:  Text(message!)),
      );
}
