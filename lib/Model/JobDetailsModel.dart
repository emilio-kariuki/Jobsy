// To parse this JSON data, do
//
//     final JobModel = JobModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<JobModel> jobModelFromJson(String str) =>
    List<JobModel>.from(json.decode(str).map((x) => JobModel.fromJson(x)));

String jobModelToJson(List<JobModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobModel {
  JobModel({
    required this.name,
    required this.description,
    required this.image,
    required this.location,
    required this.createdAt,
    required this.amount,
    required this.belongsTo,
    required this.userImage,
    required this.userName,
    required this.userRole,
  });

  String name;
  String description;
  String image;
  String location;
  String amount;
  String belongsTo;
  String userName;
  String userRole;
  String userImage;
  Timestamp createdAt;

  factory JobModel.fromJson(Map<String, dynamic> json) => JobModel(
        userName: json["userName"],
        userRole: json["userRole"],
        userImage: json["userImage"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        location: json["location"],
        createdAt: json["createdAt"],
        amount: json["amount"],
        belongsTo: json["belongsTo"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "userRole": userRole,
        "userImage": userImage,
        "name": name,
        "description": description,
        "image": image,
        "location": location,
        "createdAt": createdAt,
        "amount": amount,
        "belongsTo": belongsTo,
      };
}
