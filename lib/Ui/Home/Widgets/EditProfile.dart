import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

import '../../Authentication/Widget/InputField.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.roleController,
    required this.locationController,
    required this.bioController,
    required this.amountEarned,
    required this.image,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController roleController;
  final TextEditingController locationController;
  final TextEditingController bioController;
  final String? amountEarned;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 55),
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Profile",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(
              controller: nameController,
              hintText: "name",
              title: "Name",
              different: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              controller: phoneController,
              hintText: "phone",
              title: "Phone",
              different: false,
            ),
            InputField(
              controller: roleController,
              hintText: "role",
              title: "Role",
              different: false,
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              controller: locationController,
              hintText: "location",
              title: "Location",
              different: false,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Bio",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: bioController,
              obscureText: false,
              cursorColor: Colors.white,
              enabled: true,
              maxLines: 6,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
              decoration: InputDecoration(
                fillColor: secondaryColor,
                filled: true,
                hintText: "bio",
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white54,
                      fontWeight: FontWeight.w400,
                    ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(74, 77, 84, 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  //gapPadding: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      roleController.text.isEmpty ||
                      bioController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      behavior: SnackBarBehavior.floating,
                      width: 300,
                      backgroundColor: Colors.red,
                      content: Text("Please fill all the fields"),
                    ));
                  } else {
                    await FirebaseFirestore.instance
                        .collection("user")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      "name": nameController.text,
                      "phone": phoneController.text,
                      "role": roleController.text,
                      "bio": bioController.text,
                      "location": locationController.text,
                      "amountEarned": amountEarned,
                      "image": image,
                      "userId": FirebaseAuth.instance.currentUser!.uid,
                      "createdAt": DateTime.now().toString(),
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        behavior: SnackBarBehavior.floating,
                        width: 300,
                        backgroundColor: Colors.green,
                        content: Text("Profile updated"),
                      ));
                    });
                  }
                },
                child: Center(
                  child: Text(
                    "Update",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
