import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Repository {
  Future uploadJobImage({required image, required String path}) async {
    var snapshot =
        await FirebaseStorage.instance.ref().child("jobs/$path").putBlob(image);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future updateProfilePic({required image, required String path}) async {
    var snapshot =
        await FirebaseStorage.instance.ref().child("jobs/$path").putBlob(image);
    String downloadUrl = await snapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"image": downloadUrl});
    return downloadUrl;
  }
}
