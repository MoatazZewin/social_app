import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_cubit/home_cubit.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/shared/styles/icon_broken.dart';

import '../../shared/components/components.dart';

class NewPosts extends StatelessWidget {
  const NewPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(builder: (context, state)
        {
          var textController = TextEditingController();
          return Scaffold(
            appBar: defaultAppBar(context: context, title: 'Create Post',
                actions: [
                  TextButton(onPressed: (){
                    if(HomeCubit.get(context).postImage == null)
                      {
                        HomeCubit.get(context).createPost(dataTime: DateTime.now().toString(), text: textController.text);
                      }else{
                      HomeCubit.get(context).uploadPostImage(dataTime: DateTime.now().toString(), text: textController.text);
                    }
                  }, child: const Text('POST')),
                ]),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is CreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is CreatePostLoadingState)
                    const SizedBox(height: 10.0,),
                  Row(
                    children:  [
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            '${HomeCubit.get(context).model?.image}'
                        ),
                      ),
                      SizedBox(width: 15.0,),
                      Text('${HomeCubit.get(context).model?.name}'),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'whats is in your mind ',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  if(HomeCubit.get(context).postPath != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:FileImage(HomeCubit.get(context).postPath!),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            HomeCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(onPressed: (){
                          HomeCubit.get(context).getPostImage();
                        }, child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5.0,),
                            Text('Add Photos'),
                          ],
                        )),
                      ),
                      Expanded(
                        child: TextButton(onPressed: (){}, child: const Text('# Tags'),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }, listener: (context, states){});
  }
}
