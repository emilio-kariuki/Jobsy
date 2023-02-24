import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  Future remove({
    required String id,
    required String collection
  }) async {
    await _firestoreInstance.collection(collection).doc(id).delete();
  }

  Future<Job> getJobDetails({required String id}) async{
    var data;
    await _firestoreInstance.collection("job").doc(id).get().then((value) {
      data = value.data();
    });

    return Job.fromJson(data);
  }
}
