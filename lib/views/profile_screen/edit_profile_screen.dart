import 'dart:io';

import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import '../../consts/consts.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data})
      : super(key: key); //const EdtiProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false, // for spaching error
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            //if data image url and controller path is emty
            data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                ? Image.asset(
                    imgProfile5,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()

            // if data is not emty but controller path is emty
                : data['imageUrl'] != '' && controller.profileImagePath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()

            //else if controller path is not emty but data image url is emty
                    : Image.file(
                        File(controller.profileImagePath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                color: golden,
                onPress: () {
                  // Get.find<ProfileController>().changeImage(context); //for get profile image
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change Profile picture"),
            const Divider(),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            10.heightBox,

            customTextField(
                controller: controller.oldpassController,
                hint: passwordHint,
                title: oldpass,
                isPass: true),

            10.heightBox,

            customTextField(
                controller: controller.newpassController,
                hint: passwordHint,
                title: newpass,
                isPass: true),

            20.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(golden),
                  )
                : SizedBox(
                    width: context.screenWidth - 45,
                    child: ourButton(
                        color: golden,
                        onPress: () async {


                          controller.isloading(true);

                          //if image is not selected
                          if (controller.profileImagePath.value.isNotEmpty){
                            await controller.uploadProfileImage();
                          }else {
                            controller.profileImageLink = data ['imageUrl'];

                          }
                          //if old password matches data base

                          if (data['password'] == controller.oldpassController.text){

                            await controller.changeAuthPassword(
                              email: data['email'],
                              password:  controller.oldpassController.text,
                              newpassword: controller.newpassController.text,
                            );

                            await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text,
                            );
                            VxToast.show(context, msg: "Updated");

                          }else {
                            VxToast.show(context, msg: "Passwords do not match");
                            controller.isloading(false);
                          }



                        },
                        textColor: whiteColor,
                        title: "Save")),
          ],
        )
            .box
            .white
            .shadowSm
            .rounded
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}
