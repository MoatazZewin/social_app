import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:social_simple_app/shared/styles/icon_broken.dart';

import '../../layout/home_cubit/home_cubit.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../../modules/comment/comments_screen.dart';
import '../../modules/likes/likes_screen.dart';
import '../styles/colors.dart';



void navigateTo({required context, required widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateAndFinish({required context, required widget}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

Widget defaultTextFromField({
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  Function()? suffixOnPressed,
  bool obscure = false,
  Function(String value)? functionOnFieldSubmitted,
  required TextEditingController controller,
  required TextInputType textInputType,
  required String? Function(String? value) validatorMethod,
}) =>
    TextFormField(
      controller: controller,
      obscureText: obscure,
      onFieldSubmitted: functionOnFieldSubmitted,
      keyboardType: textInputType,
      validator: validatorMethod,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: suffixOnPressed,
        ),
      ),
    );

Widget defaultButton({
  required String text,
  double width = double.infinity,
  double radius = 3.0,
  Color background = Colors.blue,
  required Function() onPressed,
}) =>
    Container(
      height: 40.0,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void showToast({
  required String message,
  required ToastState color,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseColor(color),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCESS, EROERR, WARNING }

Color chooseColor(ToastState choose) {
  Color color;
  switch (choose) {
    case ToastState.SUCESS:
      color = Colors.green;
      break;
    case ToastState.EROERR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget buildProductItem( model, context,{bool isOldPrice = true}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model?.image}'),
                width: 120,
                height: 120,
              ),
              if (model?.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "'${model?.description}'",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model?.price}',
                      style: TextStyle(
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    if (model?.discount != 0 && isOldPrice)
                      Text(
                        '${model?.oldPrice}',
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // HomeCubit.get(context)
                        //     .changeFavoritesDataModel(model!.id);
                      },
                      icon: const Icon(
                        Icons.favorite,
                      ),
                      color:  Colors.grey,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


 defaultAppBar({
  required BuildContext context,
  required String title,
  double? elevation ,
  List<Widget>? actions,
})
{
  return AppBar(
    elevation: elevation,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: const Icon(
        IconBroken.Arrow___Left_2,
      ),
    ),
    title: Text(title),
    titleSpacing: 5.0,
    actions: actions,

  );
}


String formattedDate(Timestamp timeStamp)
{
  var dateFormTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat('KK:mm a').format(dateFormTimeStamp);
}

String formattedDateFullDate(timeStamp)
{
  var dateFormTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat('dd-MM-yyyy KK:mm a').format(dateFormTimeStamp);
}

Widget buildPostItem(PostModel model, context, index , UserModel user, number) => Card(
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
              backgroundImage: NetworkImage('${model.image}'),
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
                    formattedDateFullDate(model.dateTime),
                    style: Theme.of(context).textTheme.caption?.copyWith(
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
        if (model.postImage != '')
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 15.0,
            ),
            child: Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage('${model.postImage}'),
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
                  onTap: () {
                    navigateTo(context: context, widget: LikesScreen(model: model));
                  },
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
                        Text(
                          number == 1?'${HomeCubit.get(context).likes[index]}':'${HomeCubit.get(context).likesForUsersPosts[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
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
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          number == 1 ?'${HomeCubit.get(context).comments[index]}':'${HomeCubit.get(context).commentForUsersPosts[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
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
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  navigateTo(context: context, widget: CommentsScreen(post: model, user: user, postId: HomeCubit.get(context).postIds[index],numberOfComment: HomeCubit.get(context).comments, index:index) );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15.0,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text('write a comment....'),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                number == 1?
                HomeCubit.get(context).likePost(
                    HomeCubit.get(context).postIds[index], index, model , user, number):
                HomeCubit.get(context).likePost(
                    HomeCubit.get(context).postIdsForOwen[index], index, model , user, number);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      // IconBroken.Heart,
                      Icons.favorite,
                      color: (number == 1? HomeCubit.get(context)
                          .postUserLikes
                          .containsKey(
                          HomeCubit.get(context).postIds[index]): model.likes!.contains(user.uId))
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(
                          color: (number == 1? HomeCubit.get(context)
                              .postUserLikes
                              .containsKey(HomeCubit.get(context)
                              .postIds[index]) : model.likes!.contains(user.uId))
                              ? Colors.blue
                              : Colors.grey),
                    ),
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
