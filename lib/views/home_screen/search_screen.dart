import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';


class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,

      appBar: AppBar(),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
            if (!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }else if (snapshot.data!.docs.isEmpty) {
              return "No products fount".text.makeCentered();
            }else {
              return Container(
                color: Colors.red,
              );
            }
          }

      ),
    );
  }
}
