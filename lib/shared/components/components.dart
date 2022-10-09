import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      height: 50.0,
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
