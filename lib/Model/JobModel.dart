// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

import 'dart:convert';

List<Job> jobFromJson(String str) => List<Job>.from(json.decode(str).map((x) => Job.fromJson(x)));

String jobToJson(List<Job> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Job {
    Job({
        required this.name,
        required this.description,
        required this.image,
        required this.location,
        required this.createdAt,
        required this.amount,
        required this.userId,
    });

    String name;
    String description;
    String image;
    String location;
    String createdAt;
    String amount;
    String userId;

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        name: json["name"],
        description: json["description"],
        image: json["image"],
        location: json["location"],
        createdAt: json["createdAt"],
        amount: json["amount"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image": image,
        "location": location,
        "createdAt": createdAt,
        "amount": amount,
        "userId": userId,
    };
}
