import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/layout/home_cubit/home_cubit.dart';
import 'package:social_simple_app/layout/home_cubit/home_states.dart';
import 'package:social_simple_app/models/user_model.dart';

import '../../shared/components/components.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          UserModel? user = HomeCubit.get(context).model;
          return HomeCubit.get(context).model != null
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
                          return  buildItemStory();
                        }),
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) => buildPostItem(
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

  Widget buildItemStory()
  {
    return GestureDetector(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
