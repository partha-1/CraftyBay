import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating a method to change screen
  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      //using getx
      // Get.to(()=> const LoginScreen());
      

      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(() => const LoginScreen());
        }else{
          Get.to(() => const Home());
        }
      });

    });
  }
  @override
  void initState() {
    changeScreen();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.green50,

      body: Column(
        children: [
          Align(alignment: Alignment.topLeft,child: Image.asset(icSplashBg,width: 250,)),
          20.heightBox,
          applogoWidget(),
          10.heightBox,

          Spacer(),
          CircularProgressIndicator(
            color: Colors.cyan,
          ),
          30.heightBox,
          appversion.text.black.make(),
          30.heightBox,

        ],
      ),
    );
  }
}
