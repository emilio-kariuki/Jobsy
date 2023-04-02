import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobsy_flutter/Model/UserModel.dart';

class FirebaseAuthentication {
  final _firestoreInstance = FirebaseFirestore.instance;

  void createUser({required UserModel user, required String id}) async {
    await _firestoreInstance.collection("user").doc(id).set(
      {
        "userId": user.userId,
        "name": user.name,
        "email": user.email,
        "phone": user.phone,
        "bio": user.bio,
        "image": user.image,
        "location": user.location,
        "role": user.role,
        "createdAt": user.createdAt,
        "amountEarned": user.amountEarned,
      },
    );
  }

  Future<UserModel> getUser({required String userId}) async {
    var data;
    await _firestoreInstance.collection("user").doc(userId).get().then((value) {
      data = value.data();
    });
    return UserModel.fromJson(data);
  }

  
}
