import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';

import '../../consts/consts.dart';

import '../../widgets_common/applogo_notext_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller  = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogonotextWidget(),
            "Sign up to $appname"
                .text
                .fontFamily(bold)
                .color(golden)
                .size(15)
                .make(),
            20.heightBox,
            Obx(()=>Column(
                children: [
                  customTextField(hint: nameHint, title: name,controller: nameController,isPass:false),
                  customTextField(hint: emailHint, title: email,controller: emailController,isPass:false),
                  customTextField(hint: passwordHint, title: password,controller: passwordController,isPass:true),
                  customTextField(hint: passwordHint, title: retypePassword,controller: passwordRetypeController,isPass: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),

                  Row(
                    children: [
                      Checkbox(
                        value: isCheck,
                        checkColor: primaryColor,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(text: const TextSpan(
                          children: [
                            TextSpan(text: "I agree to the ", style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),

                            TextSpan(text: termAndCond, style: TextStyle(
                              fontFamily: regular,
                              color: primaryColorLight3,
                            )),

                            TextSpan(text: " & ", style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),

                            TextSpan(text: privacyPolicy, style: TextStyle(
                              fontFamily: regular,
                              color: primaryColorLight3,
                            )),
                          ],
                        )),
                      ),

                    ],
                  ),
                  5.heightBox,
                  controller.isloading.value?const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(primaryColor),

                  ): ourButton(
                      color: isCheck == true? primaryColor : lightGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () async {
                        if(isCheck != false){
                          controller.isloading(true);
                          try {
                            await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value) {
                              return controller.storeUserData(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                              );
                            }).then((value) {
                              VxToast.show(context, msg: loggedin);
                              Get.offAll(()=>Home());
                            });

                          }catch(e) {
                            auth.signOut();
                            VxToast.show(context, msg: e.toString());
                            controller.isloading(false);

                          }

                        }
                      })
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  //wrapping into gesture detector of velocity X
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     allreadyHaveAccount.text.color(fontGrey).make(),
                     login .text.color(primaryColorLight3).make().onTap(() {
                       Get.back();
                     }),
                   ],
                 ),

                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
