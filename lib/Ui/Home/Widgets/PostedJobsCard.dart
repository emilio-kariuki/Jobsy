// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/Favourite/favourites_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/UserModel.dart';
import 'package:jobsy_flutter/Ui/Authentication/Widget/InputField.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

enum menuValues { edit, delete }

class MyJobsCard extends StatelessWidget {
  final String image;
  final String sender;
  final String role;
  final String title;
  final String amount;
  final String description;
  final String location;
  final String jobId;
  final String collection;
  final String userImage;
  final String userRole;
  final String userName;
  final String belongsTo;
  final String? id;
  final Timestamp time;
  int index;
  MyJobsCard(
      {super.key,
      required this.image,
      required this.sender,
      required this.role,
      required this.title,
      required this.amount,
      required this.description,
      required this.location,
      required this.jobId,
      required this.collection,
      this.index = 0,
      required this.userImage,
      required this.userRole,
      required this.userName,
      required this.belongsTo,
      this.id,
      required this.time});

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesBloc(),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ImageNetwork(
              image: image,
              height: 150,
              width: 250,
              duration: 10,
              onPointer: true,
              debugPrint: false,
              fullScreen: false,
              onLoading: const CircularProgressIndicator(
                color: Colors.indigoAccent,
              ),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              onError: const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                return showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        content: SizedBox(
                                          height: 300,
                                          width: 250,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ImageNetwork(
                                                image: userImage,
                                                height: 40,
                                                width: 40,
                                                duration: 10,
                                                onPointer: true,
                                                debugPrint: false,
                                                fullScreen: false,
                                                onLoading:
                                                    const CircularProgressIndicator(
                                                  color: Colors.indigoAccent,
                                                ),
                                                onError: const Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                userName,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                userRole,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              FutureBuilder<UserModel>(
                                                  future:
                                                      FirebaseAuthentication()
                                                          .getUser(
                                                              userId:
                                                                  belongsTo),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        snapshot.data?.bio ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 11),
                                                      );
                                                    }
                                                    return const CircularProgressIndicator();
                                                  }),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: ImageNetwork(
                                image: userImage,
                                height: 30,
                                width: 30,
                                duration: 10,
                                onPointer: true,
                                debugPrint: false,
                                fullScreen: false,
                                borderRadius: BorderRadius.circular(100),
                                onLoading: const CircularProgressIndicator(
                                  color: Colors.indigoAccent,
                                ),
                                onError: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sender,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  role,
                                  style: const TextStyle(
                                      color: Colors.white54, fontSize: 11),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      PopupMenuButton<menuValues>(
                        color: bgColor,
                        onSelected: (value) {
                          switch (value) {
                            case menuValues.delete:
                              FirebaseJob().deleteJob(id: id!);

                              break;
                            case menuValues.edit:
                              nameController.text = title;
                              amountController.text = amount;
                              descriptionController.text = description;
                              showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: bgColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      content: SizedBox(
                                        height: 450,
                                        width: 350,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Center(
                                              child: Text(
                                                "Edit Job",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            InputField(
                                              controller: nameController,
                                              title: "Name",
                                              hintText: "name",
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Description",
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            TextFormField(
                                              controller: descriptionController,
                                              obscureText: false,
                                              cursorColor: Colors.white,
                                              enabled: true,
                                              maxLines: 6,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    color: Colors.white,
                                                  ),
                                              decoration: InputDecoration(
                                                fillColor: secondaryColor,
                                                filled: true,
                                                hintText: "description",
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: Colors.white54,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        74, 77, 84, 0.2),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  //gapPadding: 16,
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .error,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .error,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            InputField(
                                              controller: amountController,
                                              title: "Amount",
                                              hintText: "amount",
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            SizedBox(
                                              height: 45,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: primaryColor,
                                                  // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if (nameController.text.isEmpty ||
                                                      nameController
                                                          .text.isEmpty ||
                                                      descriptionController
                                                          .text.isEmpty ||
                                                      amountController
                                                          .text.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      width: 300,
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                          "Please fill all the fields"),
                                                    ));
                                                  } else {
                                                    await FirebaseJob().editJob(
                                                        id: id!,
                                                        name:
                                                            nameController.text,
                                                        amount: amountController
                                                            .text,
                                                        description:
                                                            descriptionController
                                                                .text,
                                                        image: image,
                                                        location: location,
                                                        createdAt:
                                                            Timestamp.now(),
                                                        belongsTo: belongsTo,
                                                        userName: userName,
                                                        userRole: userRole,
                                                        userImage: userImage);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "Update",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
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
                                  });
                              break;
                          }
                        },
                        child: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 20,
                        ),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: menuValues.edit,
                            child: Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const PopupMenuItem(
                            value: menuValues.delete,
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.clip,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "\$$amount",
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
