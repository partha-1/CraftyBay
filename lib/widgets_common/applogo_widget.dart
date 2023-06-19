import 'package:emart_app/consts/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget applogoWidget(){
  //using velocity x here
  return Image.asset(icAppLogo).box.size(130, 130).padding(const EdgeInsets.all(8)).rounded.make();
}