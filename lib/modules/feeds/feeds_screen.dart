import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_cubit/home_cubit.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/models/user_model.dart';

import '../../shared/components/components.dart';
import '../story/story_screen.dart';

class FeedsScreen extends StatelessWidget {
  List<String> stories = [
    'hello',
    'second story',
    'third story'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          UserModel? user = HomeCubit.get(context).model;
          return (HomeCubit.get(context).usersForPosts.length >0 && HomeCubit.get(context).posts.length >0)
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                          return  buildItemStory(context);
                        }),
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) => buildPostItem(HomeCubit.get(context).usersForPosts,
                            HomeCubit.get(context).posts[index],
                            context,
                            index, user!, 1),
                        separatorBuilder: (context, index) => const SizedBox(
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
                )
              : const Center(child: CircularProgressIndicator());
        },
        listener: (context, state) {});
  }

  Widget buildItemStory(context)
  {
    return GestureDetector(
      onTap: (){
        navigateTo(context: context, widget: StoryScreen(stories:stories,));
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.green,
          radius: 25.5,
          child: CircleAvatar(
            radius: 23.0,
            backgroundImage: NetworkImage('https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
          ),
        ),
      ),
    );
  }
}
