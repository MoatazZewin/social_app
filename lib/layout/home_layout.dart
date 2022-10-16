import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/modules/new_posts/new_posts.dart';
import 'package:social_simple_app/shared/components/components.dart';
import 'package:social_simple_app/shared/styles/icon_broken.dart';

import 'home_cubit/home_cubit.dart';
import 'home_cubit/home_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if(state is NewPostsState)
            {
              navigateTo(context: context, widget: NewPosts());
            }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentIndex]),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(IconBroken.Notification)),
                IconButton(
                    onPressed: () {}, icon: const Icon(IconBroken.Search)),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: 'Posts'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: 'Location'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Setting'),
              ],
              currentIndex: cubit.currentIndex >= 2 ?cubit.currentIndex+1:cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
