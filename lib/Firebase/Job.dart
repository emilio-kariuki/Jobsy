// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Model/JobDetailsModel.dart';

import '../Model/JobModel.dart';

class FirebaseJob {
  final _firestoreInstance = FirebaseFirestore.instance;
  Future createJob({required Job job, required BuildContext context}) async {
    try {
      await _firestoreInstance.collection("job").doc().set({
        "name": job.name,
        "description": job.description,
        "image": job.image,
        "location": job.location,
        "createdAt": job.createdAt,
        "amount": job.amount,
        "belongsTo": job.belongsTo,
        "userName": job.userName,
        "userRole": job.userRole,
        "userImage": job.userImage,
      }, SetOptions(merge: true));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        behavior: SnackBarBehavior.floating,
        width: 300,
        backgroundColor: Colors.green,
        content: Text("Job posted successfully"),
      ));
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteJob({required String id}) async {
    await _firestoreInstance.collection('job').doc(id).delete();
  }

  Future<List<Job>> getJobs({required String belongsTo}) async {
    var data;
    await _firestoreInstance
        .collection("job")
        .where("belongsTo", isGreaterThanOrEqualTo: belongsTo)
        .get()
        .then((value) {
      data = value.docs;
    });

    return data.map<Job>((e) => Job.fromJson(e.data())).toList();
  }

  Future addToFavourite({required String userId, required Job job}) async {
    await _firestoreInstance.collection("user").doc(userId).update({
      "favourite": FieldValue.arrayUnion([
        {
          "name": job.name,
          "description": job.description,
          "image": job.image,
          "location": job.location,
          "createdAt": job.createdAt,
          "amount": job.amount,
          "belongsTo": job.belongsTo,
        }
      ])
    });
  }

  Future createFavourite(
      {required Job job, required BuildContext context}) async {
    try {
      await _firestoreInstance.collection("favourite").doc().set({
        "name": job.name,
        "description": job.description,
        "image": job.image,
        "location": job.location,
        "createdAt": job.createdAt,
        "amount": job.amount,
        "belongsTo": job.belongsTo,
      }, SetOptions(merge: true));

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        behavior: SnackBarBehavior.floating,
        width: 300,
        backgroundColor: Colors.green,
        content: Text("Added to favourites"),
      ));
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future remove({required String id, required String collection}) async {
    await _firestoreInstance.collection(collection).doc(id).delete();
  }

  Future<JobModel> getJobDetails({required String id}) async {
    var data;
    await _firestoreInstance.collection("job").doc(id).get().then((value) {
      data = value.data();
    });

    return JobModel.fromJson(data);
  }

  Future addFavourite(
      {required JobModel job,
      required String id,
      required BuildContext context}) async {
    await _firestoreInstance.collection("user").doc(id).update({
      "favourite": FieldValue.arrayUnion([
        {
          "name": job.name,
          "description": job.description,
          "image": job.image,
          "location": job.location,
          "createdAt": job.createdAt,
          "amount": job.amount,
          "belongsTo": job.belongsTo,
          "userName": job.userName,
          "userRole": job.userRole,
          "userImage": job.userImage,
        }
      ])
    });
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      behavior: SnackBarBehavior.floating,
      width: 300,
      backgroundColor: Colors.green,
      content: Text("Added to favourites"),
    ));
  }

  Future<List<JobModel>> getFavourites({required String userId}) async {
    var data;
    await _firestoreInstance.collection("user").doc(userId).get().then((value) {
      data = value.data();
    });

    return data["favourite"]
        .map<JobModel>((e) => JobModel.fromJson(e))
        .toList();
  }

  Future<List<JobModel>> getAppliedJobs({required String userId}) async {
    var data;
    await _firestoreInstance.collection("user").doc(userId).get().then((value) {
      data = value.data();
    });

    return data["appliedJobs"]
        .map<JobModel>((e) => JobModel.fromJson(e))
        .toList();
  }

  Future<List<Job>> getClaimedJobs({required String userId}) async {
    var data;
    await _firestoreInstance.collection("user").doc(userId).get().then((value) {
      data = value.data();
    });

    return data["claimedJobs"].map<Job>((e) => Job.fromJson(e)).toList();
  }

  Future applyJob(
      {required String userId,
      required String appliedBy,
      required Job job}) async {
    await _firestoreInstance.collection("user").doc(userId).update({
      "claimedJobs": FieldValue.arrayUnion([
        {
          "name": job.name,
          "description": job.description,
          "image": job.image,
          "location": job.location,
          "createdAt": job.createdAt,
          "amount": job.amount,
          "belongsTo": job.belongsTo,
          "userName": job.userName,
          "userRole": job.userRole,
          "userImage": job.userImage,
          "appliedBy": appliedBy,
        }
      ])
    });
  }

  Future applyJobs({required String userId, required Job job}) async {
    await _firestoreInstance.collection("user").doc(userId).update({
      "appliedJobs": FieldValue.arrayUnion([
        {
          "name": job.name,
          "description": job.description,
          "image": job.image,
          "location": job.location,
          "createdAt": job.createdAt,
          "amount": job.amount,
          "belongsTo": job.belongsTo,
          "userName": job.userName,
          "userRole": job.userRole,
          "userImage": job.userImage,
        }
      ])
    });
  }

  Future deleteClaimedJob({
    required String userId,
    required int index,
  }) async {
    await _firestoreInstance.collection("user").doc(userId).update({
      "claimedJobs": FieldValue.arrayRemove([index])
    });
  }

  Future<List<JobModel>> getJobsByUser({required String userId}) async {
    var data;
    await _firestoreInstance
        .collection("job")
        .where("belongsTo", isEqualTo: userId)
        .get()
        .then((value) {
      data = value.docs;
    });

    return data.map<JobModel>((e) => JobModel.fromJson(e.data())).toList();
  }

  Future removeFavourite({
    required String userId,
    required int index,
  }) async {
    await _firestoreInstance.collection("user").doc(userId).update(
      {
        "favourite": FieldValue.delete(),
      },
    );
  }

  Future removeFavorite({
    required String userId,
    required int index,
  }) async {
    await _firestoreInstance.collection("user").doc(userId).update({
      "favourite": FieldValue.delete(),
    });
  }

  Future<List<JobModel>> searchJob({required String job}) async {
    var data;
    await _firestoreInstance
        .collection('job')
        .where('name', isEqualTo: job)
        .get()
        .then((value) {
      data = value.docs;
    });
    return jobModelFromJson(data);
  }

  Future deleteFavouriteJob({required int index}) async {
    final docRef = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    await docRef.get().then((snapshot) async {
      if (snapshot.exists) {
        final fieldValueList = List.from(snapshot.data()!['favourite']);
        fieldValueList.removeAt(index);
        docRef
            .update({
              'favourite': fieldValueList,
            })
            .then((value) => print('Item removed successfully'))
            .catchError((error) => print('Failed to remove item: $error'));
      } else {
        print('Document does not exist');
      }
    }).catchError((error) => print('Failed to get document: $error'));
  }

  Future deleteAppliedJob({required int index, required String otherId}) async {
    final docRef = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final otherRef = FirebaseFirestore.instance.collection('user').doc(otherId);

    await docRef.get().then((snapshot) async {
      if (snapshot.exists) {
        final fieldValueList = List.from(snapshot.data()!['appliedJobs']);
        fieldValueList.removeAt(index);
        docRef
            .update({
              'appliedJobs': fieldValueList,
            })
            .then((value) => print('Item removed successfully'))
            .catchError((error) => print('Failed to remove item: $error'));
      } else {
        print('Document does not exist');
      }
    }).catchError((error) => print('Failed to get document: $error'));

    await otherRef.get().then((snapshot) async {
      if (snapshot.exists) {
        final fieldValueList = List.from(snapshot.data()!['claimedJobs']);
        fieldValueList.removeAt(index);
        otherRef
            .update({
              'claimedJobs': fieldValueList,
            })
            .then((value) => print('Item removed successfully'))
            .catchError((error) => print('Failed to remove item: $error'));
      } else {
        print('Document does not exist');
      }
    }).catchError((error) => print('Failed to get document: $error'));
  }

  Future editJob(
      {required String id,
      required String name,
      required String amount,
      required String description,
      required String image,
      required String location,
      required Timestamp createdAt,
      required String belongsTo,
      required String userName,
      required String userRole,
      required String userImage}) async {
    await _firestoreInstance.collection("job").doc(id).update({
      "name": name,
      "description": description,
      "image": image,
      "location": location,
      "createdAt": createdAt,
      "amount": amount,
      "belongsTo": belongsTo,
      "userName": userName,
      "userRole": userRole,
      "userImage": userImage,
    });
  }
}
