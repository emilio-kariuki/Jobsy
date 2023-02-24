import 'package:firebase_storage/firebase_storage.dart';

class Repository {
  Future uploadJobImage({required image, required String path}) async {
    var snapshot =
        await FirebaseStorage.instance.ref().child("jobs/$path").putBlob(image);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
