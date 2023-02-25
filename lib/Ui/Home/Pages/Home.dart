import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobsy_flutter/Blocs/Get%20User/get_user_bloc.dart';
import 'package:jobsy_flutter/Blocs/ShowPost/show_post_bloc.dart';
import 'package:jobsy_flutter/Blocs/UploadImage/image_upload_bloc.dart';
import 'package:jobsy_flutter/Ui/Home/HomePage.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/3JobsGrid.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/4JobsDrid.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/MessengerSnack.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/PostForm.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ProfileCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

import '../../../Firebase/Job.dart';
import '../../../Model/JobModel.dart';
import '../../Authentication/Widget/InputField.dart';

class Home extends StatefulWidget {
  final PageController controller;
  final SideMenuController sideMenuController;
  const Home(
      {super.key, required this.controller, required this.sideMenuController});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = TextEditingController();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  bool isDetails = false;
  int _value = 1;
  String? name;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        name = value.data()!["name"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImageUploadBloc(),
        ),
        BlocProvider(
          create: (context) => ShowPostBloc(),
        ),
        BlocProvider(
          create: (context) => GetUserBloc()
            ..add(GetUser(userId: FirebaseAuth.instance.currentUser!.uid)),
        ),
      ],
      child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello ${name ?? ""} 👋",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "Welcome to Jobsy Home",
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: InputField(
                        controller: searchController,
                        hintText: "search job",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                     BlocBuilder<ShowPostBloc, ShowPostState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 45,
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: state is ShowPostInitial
                            ? () {
                                BlocProvider.of<ShowPostBloc>(context)
                                    .add(AddPostPressed());
                              }
                            : () {
                                BlocProvider.of<ShowPostBloc>(context)
                                    .add(RemovePostPressed());
                              },
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              state is ShowPostInitial
                                  ? Icons.add
                                  : Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            state is ShowPostInitial
                                ? Text(
                                    "Add Post",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  )
                                : Text(
                                    "Close",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                          ],
                        )),
                      ),
                    );
                  },
                ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
               
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ShowPostBloc, ShowPostState>(
                  builder: (context, state) {
                    return Expanded(
                      flex: 5,
                      child: state is ShowPostInitial
                          ? const JobsGrid()
                          : Row(
                              children: [
                                const Jobs3Grid(),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  height: MediaQuery.of(context).size.height *
                                      0.7,
                                  width: MediaQuery.of(context).size.width *
                                      0.24,
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Post Job",
                                          style: GoogleFonts.roboto(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      PostForm(
                                        titleController: titleController,
                                        amountController: amountController,
                                        descriptionController:
                                            descriptionController,
                                      ),

                                      //upload button

                                      Row(
                                        children: [
                                          BlocBuilder<ImageUploadBloc,
                                              ImageUploadState>(
                                            builder: (context, state) {
                                              if (state
                                                  is ImageUploadSuccess) {
                                                () async {
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          const MessengerSnack(
                                                                  message:
                                                                      "Image upload success")
                                                              as SnackBar);
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomePage(),
                                                    ),
                                                  );
                                                };
                                              }

                                              if (state
                                                  is ImageUploadFailure) {
                                                () async {
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          MessengerSnack(
                                                                  message: state
                                                                      .error)
                                                              as SnackBar);
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const HomePage(),
                                                    ),
                                                  );
                                                };
                                              }

                                              return state
                                                      is ImageUploadLoading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ))
                                                  : SizedBox(
                                                      height: 45,
                                                      width: 110,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              primaryColor,
                                                          // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          FileUploadInputElement
                                                              input =
                                                              FileUploadInputElement()
                                                                ..accept =
                                                                    'image/*';

                                                          input.click();
                                                          input.onChange
                                                              .listen(
                                                                  (event) {
                                                            final files =
                                                                input.files!
                                                                    .first;
                                                            final reader =
                                                                FileReader();
                                                            reader
                                                                .readAsDataUrl(
                                                                    files);
                                                            reader.onLoadEnd
                                                                .listen(
                                                                    (event) {
                                                              BlocProvider.of<
                                                                          ImageUploadBloc>(
                                                                      context)
                                                                  .add(
                                                                UploadButtonPressed(
                                                                    image:
                                                                        files,
                                                                    path: files
                                                                        .name),
                                                              );
                                                            });
                                                          });
                                                        },
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                Icons.upload,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Upload",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //post button
                                      BlocBuilder<ImageUploadBloc,
                                          ImageUploadState>(
                                        builder: (context, state) {
                                          if (state is ImageUploadInitial) {
                                            return const Center(
                                              child: Text(
                                                "upload image first",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          } else if (state
                                              is ImageUploadLoading) {
                                            return const Center(
                                              child: Text(
                                                "Uploading....",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          } else if (state
                                              is ImageUploadSuccess) {
                                            return SizedBox(
                                              height: 45,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                style:
                                                    ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      primaryColor,
                                                  // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  if (titleController
                                                          .text.isEmpty ||
                                                      amountController
                                                          .text.isEmpty ||
                                                      descriptionController
                                                          .text.isEmpty) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20))),
                                                      behavior:
                                                          SnackBarBehavior
                                                              .floating,
                                                      width: 300,
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                          "Please fill all the fields"),
                                                    ));
                                                  } else {
                                                    FirebaseJob().createJob(
                                                      job: Job(
                                                        name: titleController
                                                            .text,
                                                        description:
                                                            descriptionController
                                                                .text,
                                                        image: state.imageUrl,
                                                        location:
                                                            await SharedPreferencesManager()
                                                                .getUserLocation(),
                                                        createdAt:
                                                            Timestamp.now(),
                                                        amount:
                                                            amountController
                                                                .text,
                                                        belongsTo:
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                        userImage:
                                                            await SharedPreferencesManager()
                                                                .getUserImage(),
                                                        userName:
                                                            await SharedPreferencesManager()
                                                                .getUserName(),
                                                        userRole:
                                                            await SharedPreferencesManager()
                                                                .getRole(),
                                                      ),
                                                      context: context,
                                                    );

                                                    titleController.clear();
                                                    descriptionController
                                                        .clear();
                                                    amountController.clear();
                                                    locationController
                                                        .clear();
                                                    locationController
                                                        .clear();
                                                  }
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "Post",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          color: Colors.white,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (state
                                              is ImageUploadFailure) {
                                            return const Text(
                                              "Image not uploaded",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}