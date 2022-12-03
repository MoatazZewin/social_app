import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_cubit/home_cubit.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/shared/components/components.dart';
import 'package:social_simple_app/shared/styles/colors.dart';
import 'package:social_simple_app/shared/styles/icon_broken.dart';

import '../../models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(builder: (context, state)
        {
          return   HomeCubit.get(context).model != null ?SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                    const Image(
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg')),
                    Text(
                      'communicate with friends ',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ]),
                ),
                ListView.separated(itemBuilder: (context, index)=>buildPostItem(HomeCubit.get(context).posts[index],context, index),
                  separatorBuilder: (context, index)=> const SizedBox(
                    height: 2.0,
                  ),
                  itemCount: HomeCubit.get(context).posts.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
                const SizedBox(
                  height: 8.0,
                )
              ],
            ),
          ):const Center(child: CircularProgressIndicator());
        }, listener: (context, state)
    {

    });
  }

  Widget buildPostItem(PostModel model, context, index)=>Card(
    elevation: 5.0,
    margin: const EdgeInsets.all(8.0),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                         Text(
                          '${model.name}',
                          style: const TextStyle(
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        Icon(
                          Icons.check_circle,
                          color: defaultColor,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style:
                      Theme.of(context).textTheme.caption?.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     bottom: 10.0,
          //     top: 5.0,
          //   ),
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //             end: 6.0,
          //           ),
          //           child: SizedBox(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style:Theme.of(context).textTheme.caption?.copyWith(
          //                   color: defaultColor,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if(model.postImage != '')
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15.0,
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      '${model.postImage}'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text('${HomeCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 5.0,),
                          Text('0 Comment',
                            style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:  [
              Expanded(
                child: InkWell(
                  onTap:(){},
                  child: Row(
                    children:  [
                      CircleAvatar(
                        radius: 15.0,
                        backgroundImage: NetworkImage(
                            '${model.image}'),
                      ),
                      SizedBox(width: 5.0,),
                      Text('write a comment....'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  HomeCubit.get(context).likePost(HomeCubit.get(context).postIds[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 5.0,),
                      Text('Like',
                        style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    ),
  );
}
