// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.phone,
    this.bio,
    this.image,
    this.location,
    this.role,
    required this.createdAt,
    this.amountEarned,
  });

  String userId;
  String name;
  String email;
  String? phone;
  String? bio;
  String? image;
  String? location;
  String? role;
  dynamic createdAt;
  String? amountEarned;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        bio: json["bio"],
        image: json["image"],
        location: json["location"],
        role: json["role"],
        createdAt: json["createdAt"],
        amountEarned: json["amountEarned"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "phone": phone,
        "bio": bio,
        "image": image,
        "location": location,
        "role": role,
        "createdAt": createdAt,
        "amountEarned": amountEarned,
      };
}
