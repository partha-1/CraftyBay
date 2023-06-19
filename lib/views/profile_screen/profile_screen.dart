import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';

import '../../consts/consts.dart';
import 'components/details_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              }else {
                var data = snapshot.data!.docs[0];



                return SafeArea(
                    child: Column(
                      children: [
                        //edit profile button


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.settings,color: Colors.white,)).onTap(() {

                                 controller.nameController.text = data['name'];


                            Get.to(() => EditProfileScreen(data: data));
                          }),
                        ),




                        //users details section
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == ''?
                              Image.asset(
                                imgProfile3,
                                width: 68,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make()
                                  :
                              Image.network(
                                data['imageUrl'],
                                width: 68,
                                fit: BoxFit.cover,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),


                              10.widthBox,
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "${data['name']}".text.fontFamily(semibold).white.make(),

                                      "${data['email']}".text.white.make(),
                                    ],
                                  )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: whiteColor,
                                      )
                                  ),
                                  onPressed: () async{
                                    await Get.put(AuthController()).signoutMethod(context);
                                    Get.offAll(()=>const LoginScreen());
                                  },
                                  child: logout.text.fontFamily(semibold).white.make()),
                            ],
                          ),
                        ),
                        20.heightBox,


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(count: data['cart_count'], title: "in your cart", width: context.screenWidth/ 3.3),
                            detailsCard(count: data['wishlist_count'], title: "in your wishlist", width: context.screenWidth/ 3.3),
                            detailsCard(count: data['order_count'], title: "your orders", width: context.screenWidth/ 3.3),
                          ],
                        ),

                        // buttons section


                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context,index){
                            return const Divider(
                                color: darkFontGrey
                            );
                          },
                          itemCount: profileButtonsList.length,
                          itemBuilder: (BuildContext context, int index){
                            return ListTile(
                              leading: Image.asset(profileButtonsIcon[index],
                                width: 22,
                              ),
                              title: profileButtonsList [index].text.fontFamily(semibold).color(darkFontGrey).make(),
                            );
                          },

                        ).box.white.rounded.margin(EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(primaryColor).make(),


                      ],
                    ));

              }


            }),
      ),
    );
  }
}
