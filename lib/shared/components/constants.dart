import 'package:flutter/cupertino.dart';

import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context)
{
  CacheHelper.remove(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context: context, widget: LoginScreen());
    }
  });

}

 String? token ;
 String? uId;
 bool? isFromLogin;
 bool? isFromRegister;

 // Widget card()
 // {
 //   return Card(
 //     elevation: 5.0,
 //     margin: const EdgeInsets.all(8.0),
 //     clipBehavior: Clip.antiAliasWithSaveLayer,
 //     child: Stack(
 //         alignment: AlignmentDirectional.bottomEnd,
 //         children: [
 //           const Image(
 //               fit: BoxFit.cover,
 //               height: 200.0,
 //               width: double.infinity,
 //               image: NetworkImage(
 //                   'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg')),
 //           Text(
 //             'communicate with friends ',
 //             style: Theme.of(context)
 //                 .textTheme
 //                 .subtitle1
 //                 ?.copyWith(
 //               color: Colors.white,
 //             ),
 //           ),
 //         ]),
 //   ),
 // }
 //


