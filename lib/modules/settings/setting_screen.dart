import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_simple_app/models/user_model.dart';
import 'package:social_simple_app/shared/styles/icon_broken.dart';
import '../../layout/home_cubit/home_cubit.dart';
import '../../layout/home_cubit/home_states.dart';
import '../../shared/components/components.dart';
import '../edit_profile/edit_profile.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      HomeCubit.get(context).getPosts(number: 1);
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, states){},
        builder: (context, states){
          UserModel? userModel = HomeCubit.get(context).model;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${userModel?.cover}'),
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child:  CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                                '${userModel?.image}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${userModel?.name}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    '${userModel?.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap:(){},
                            child: Column(
                              children: [
                                Text(
                                  '${HomeCubit.get(context).userPosts.length}',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap:(){},
                            child: Column(
                              children: [
                                Text(
                                  '250',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Photos',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap:(){},
                            child: Column(
                              children: [
                                Text(
                                  '10k',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Followers',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap:(){},
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text(
                                  'Following',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: OutlinedButton(onPressed: (){

                      }, child: const Text('Add Photos'))),
                      const SizedBox(width: 10.0,),
                      OutlinedButton(onPressed: (){
                        navigateTo(context: context, widget: EditProfile());
                      }, child: const Icon(IconBroken.Edit)),

                    ],
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) => buildPostItem(null,
                        HomeCubit.get(context).userPosts[index],
                        context,
                        index, userModel!, 2),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 2.0,
                    ),
                    itemCount: HomeCubit.get(context).userPosts.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                  const SizedBox(
                    height: 8.0,
                  )

                ],
              ),
            ),
          );
        },);
    });
  }
}
