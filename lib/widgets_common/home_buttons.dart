import 'package:emart_app/consts/consts.dart';

Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        color: primaryColor,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(primaryColorLight3).make()
    ],
  ).box.rounded.white.size(width, height).make();
}
