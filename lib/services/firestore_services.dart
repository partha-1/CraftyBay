import 'package:emart_app/consts/consts.dart';

//get users data
class FirestoreServices {
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // get products according to category

  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where("p_category", isEqualTo: category)
        .snapshots();
  }

  // get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where("added_by", isEqualTo: uid)
        .snapshots();
  }


  // delete document

  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }
  
  
  static allproducts(){
    return firestore.collection(productsCollection).snapshots();
  }

  //get featured products method
  static getFeaturedProducts(){
    return firestore.collection(productsCollection).where('is_featured', isEqualTo: true).get();
  }
  
  
  static searchProducts(title){
    return firestore.collection(productsCollection).where('p_name', isLessThanOrEqualTo: title  ).get();
  }

}
