// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Job> jobFromJson(String str) =>
    List<Job>.from(json.decode(str).map((x) => Job.fromJson(x)));

String jobToJson(List<Job> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Job {
  Job({
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

  factory Job.fromJson(Map<String, dynamic> json) => Job(
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
