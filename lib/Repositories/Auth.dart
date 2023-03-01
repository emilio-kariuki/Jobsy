import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Model/UserModel.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<bool> register(
      {required String name,
      required String email,
      required String password}) async {
    User? user;

    try {
      user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        FirebaseAuthentication().createUser(
            id: user.uid,
            user: UserModel(
              userId: user.uid,
              name: name,
              email: email,
              createdAt: DateTime.now(),
              phone: "0700000000",
              bio:
                  "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.",
              image:
                  "https://firebasestorage.googleapis.com/v0/b/apt-rite-346310.appspot.com/o/profile.jpg?alt=media&token=71a31f30-11ee-49b9-913c-b3682d3f6ea7",
              location: "Nairobi, Kenya",
              role: "Developer",
              amountEarned: "0",
            ));
        await SharedPreferencesManager().setUserId(value: user.uid);
        await SharedPreferencesManager().setUserEmail(value: email);
        FirebaseAuthentication()
            .getUser(userId: FirebaseAuth.instance.currentUser!.uid)
            .then((value) async {
          await SharedPreferencesManager()
              .setUserLocation(value: value.location ?? "");
          await SharedPreferencesManager()
              .setUserPhone(value: value.phone ?? "");
          await SharedPreferencesManager().setRole(value: value.role ?? "");
          await SharedPreferencesManager()
              .setUserImage(value: value.image ?? "");
          await SharedPreferencesManager().setUserName(value: value.name);
          await SharedPreferencesManager().setUserEmail(value: value.email);
        });
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    User? user;

    try {
      user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        await SharedPreferencesManager().setUserId(value: user.uid);
        await SharedPreferencesManager().setUserEmail(value: email);
        FirebaseAuthentication()
            .getUser(userId: FirebaseAuth.instance.currentUser!.uid)
            .then((value) async {
          await SharedPreferencesManager()
              .setUserLocation(value: value.location ?? "");
          await SharedPreferencesManager()
              .setUserPhone(value: value.phone ?? "");
          await SharedPreferencesManager().setRole(value: value.role ?? "");
          await SharedPreferencesManager()
              .setUserImage(value: value.image ?? "");
          await SharedPreferencesManager().setUserName(value: value.name);
          await SharedPreferencesManager().setUserEmail(value: value.email);
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
