import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/modules/story/story_cubit/story_cubit.dart';
import 'package:social_simple_app/modules/story/story_cubit/story_states.dart';

class StoryScreen extends StatelessWidget {
  List<String> stories= [];
  List<double> percentWatched = [];
  List<Widget> progress = [];
  StoryScreen({required this.stories});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoryCubit()..startWatching(stories.length, context),
      child: BlocConsumer<StoryCubit, StoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          progress = StoryCubit.get(context).progressBar;

          return GestureDetector(
            onTapDown:(details) => StoryCubit.get(context).onTapDown(details, context, stories.length),
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only( right: 5.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                         children:StoryCubit.get(context).myProgressBar(stories.length, stories),
                      ),
                    ),
                    Center(child: Text('${stories[StoryCubit.get(context).currentStoryIndex]}')),



                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
//
// Center(child: Text(myStories[1])),

//
// Stack(
// children: [
//
// Center(child: Text( StoryCubit.get(context).myStories[1])),
//
// ]),
