import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:social_simple_app/modules/story/story_cubit/story_states.dart';

class StoryCubit extends Cubit<StoryStates>
{
  StoryCubit():super(StoryInitialState());

  static StoryCubit get(context) => BlocProvider.of(context);
  int currentStoryIndex = 0;
  List<double> percentWatched = [];

  List<String> myStories = [];
  List<Widget> progressBar = [];

  void onTapDown(TapDownDetails details, context, number)
  {
    double screenWidth = MediaQuery.of(context).size.width;
    double dx = details.globalPosition.dx;
    if(dx < screenWidth/2)
      {
        if(currentStoryIndex > 0)
          {
            percentWatched[currentStoryIndex-1] =0;
            percentWatched[currentStoryIndex] =0;

            --currentStoryIndex;
            emit(StoryProgressBarChange());
          }
      }else{
      if(currentStoryIndex < number-1 )
        {
          percentWatched[currentStoryIndex]= 1;
          currentStoryIndex++;
          emit(StoryProgressBarChange());
        }else{
        percentWatched[currentStoryIndex]= 1;

      }

    }

  }

  void startWatching(number, context)
  {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if(percentWatched[currentStoryIndex] +.01 < 1)
        {
          percentWatched[currentStoryIndex] += 0.01;
          emit(StoryProgressBarChange());
        }else{
        print("the number inside if ${currentStoryIndex}");
        percentWatched[currentStoryIndex] = 1;
        timer.cancel();
        print("the number lenght is  ${number}");
        if(currentStoryIndex < number -1 )
          {
            ++currentStoryIndex;
            // emit(StoryProgressBarChange());
            print("the number inside if ${currentStoryIndex}");
            startWatching(number, context);
            emit(StoryProgressBarChange());
          }
        else{
          Navigator.pop(context);
        }
      }

    });

  }
   List<Widget> myProgressBar( number, List<String> stories) {
    List<Widget> list = [];
    myStories = stories;
    for(int x =0; x <number; x++)
    {
      percentWatched.add(0.0);
      list.add( Expanded(
        child: LinearPercentIndicator(
          padding: EdgeInsets.only(left: 5.0),
          lineHeight: 7.0,
          percent: percentWatched[x],
          progressColor: Colors.red,
          backgroundColor: Colors.grey,
        ),
      ));
    }
    progressBar = list;
    return list;
  }
}