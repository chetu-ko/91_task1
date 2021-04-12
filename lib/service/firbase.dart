import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHandel {
  var storage = FirebaseStorage.instance;
  CollectionReference images = FirebaseFirestore.instance.collection('Images');

  Future<void> uploadFile(imageselected, count) async {
    try {
      String name = "Image" + "$count";
      var snapshot =await storage
          .ref('uploads/$name')
          .putFile(imageselected);
      String downloadURL = await snapshot
          .ref.getDownloadURL();
      await images.add({"url": downloadURL, "name": name} );
          //.add({"url": downloadURL, "name": name });
    } catch (e) {
      print(e);
    }
  }

   void DeleteData(document) async {
    await FirebaseFirestore.instance.collection('Images').doc(document.id).delete();
  }

}
