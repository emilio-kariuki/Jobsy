import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobsy_flutter/Blocs/ShowPost/show_post_bloc.dart';
import 'package:jobsy_flutter/Blocs/UploadImage/image_upload_bloc.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/JobModel.dart';
import 'package:jobsy_flutter/Ui/Authentication/Widget/InputField.dart';
import 'package:jobsy_flutter/Ui/Home/Pages/ProfilePage.dart';
import 'package:jobsy_flutter/Ui/Home/Pages/ThirdPage.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/3JobsGrid.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/4JobsDrid.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/MessengerSnack.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/PostForm.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ProfileCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

int _selectedIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  bool isDetails = false;
  int _value = 1;

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
      ],
      child: Scaffold(
          backgroundColor: secondaryColor,
          // appBar: AppBar(
          //   backgroundColor: Colors.white54,
          //     elevation: 0,
          //     leading: Row(
          //       children: [
          //         IconButton(
          //           icon: const Icon(Icons.menu),
          //           onPressed: () {},
          //         ),
          //       ],
          //     )),
          body: Row(
            children: [
              NavigationRail(
                leading: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Image.asset(
                    "lib/Assets/jobsy.jpeg",
                    height: 50,
                    width: 50,
                  ),
                ),
                backgroundColor: bgColor,
                labelType: NavigationRailLabelType.all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    selectedIcon: Icon(Icons.home),
                    label: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                          child: Text('Home',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    selectedIcon: Icon(Icons.person),
                    label: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Center(
                          child: Text('Profile',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.star_border,
                      color: Colors.white,
                    ),
                    selectedIcon: Icon(Icons.star),
                    label: Text('Third'),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),

              const SizedBox(
                width: 3,
              ),

              // This is the main content.
              _selectedIndex == 0
                  ? Expanded(
                    flex: 5,
                    child: Scaffold(
                        backgroundColor: bgColor,
                        body: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
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
                                        "Hello Emilio 👋",
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.25,
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
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedIndex = 1;
                                        });
                                      },
                                      child: const ProfileCard()),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ShowPostBloc, ShowPostState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: 45,
                                        width: 150,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          onPressed: state is ShowPostInitial
                                              ? () {
                                                  BlocProvider.of<ShowPostBloc>(
                                                          context)
                                                      .add(AddPostPressed());
                                                }
                                              : () {
                                                  BlocProvider.of<ShowPostBloc>(
                                                          context)
                                                      .add(RemovePostPressed());
                                                },
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.add,
                                                color: Colors.white,
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
                                      ),
                                    ],
                                  );
                                },
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.24,
                                                decoration: BoxDecoration(
                                                  color: secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                      titleController:
                                                          titleController,
                                                      amountController:
                                                          amountController,
                                                      descriptionController:
                                                          descriptionController,
                                                    ),
                  
                                                    //upload button
                  
                                                    Row(
                                                      children: [
                                                        BlocBuilder<
                                                            ImageUploadBloc,
                                                            ImageUploadState>(
                                                          builder:
                                                              (context, state) {
                                                            if (state
                                                                is ImageUploadSuccess) {
                                                              () async {
                                                                ScaffoldMessenger
                                                                        .of(
                                                                            context)
                                                                    .showSnackBar(const MessengerSnack(
                                                                            message:
                                                                                "Image upload success")
                                                                        as SnackBar);
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacement(
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const HomePage(),
                                                                  ),
                                                                );
                                                              };
                                                            }
                  
                                                            if (state
                                                                is ImageUploadFailure) {
                                                              () async {
                                                                ScaffoldMessenger
                                                                        .of(
                                                                            context)
                                                                    .showSnackBar(MessengerSnack(
                                                                            message:
                                                                                state.error)
                                                                        as SnackBar);
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacement(
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
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
                                                                    strokeWidth:
                                                                        2,
                                                                  ))
                                                                : SizedBox(
                                                                    height: 45,
                                                                    width: 110,
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        backgroundColor:
                                                                            primaryColor,
                                                                        // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        FileUploadInputElement
                                                                            input =
                                                                            FileUploadInputElement()
                                                                              ..accept =
                                                                                  'image/*';
                  
                                                                        input
                                                                            .click();
                                                                        input
                                                                            .onChange
                                                                            .listen(
                                                                                (event) {
                                                                          final files = input
                                                                              .files!
                                                                              .first;
                                                                          final reader =
                                                                              FileReader();
                                                                          reader.readAsDataUrl(
                                                                              files);
                                                                          reader
                                                                              .onLoadEnd
                                                                              .listen((event) {
                                                                            BlocProvider.of<ImageUploadBloc>(context)
                                                                                .add(
                                                                              UploadButtonPressed(
                                                                                  image: files,
                                                                                  path: files.name),
                                                                            );
                                                                          });
                                                                        });
                                                                      },
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.upload,
                                                                              color:
                                                                                  Colors.white,
                                                                              size:
                                                                                  20,
                                                                            ),
                                                                            const SizedBox(
                                                                              width:
                                                                                  5,
                                                                            ),
                                                                            Text(
                                                                              "Upload",
                                                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                    color: Colors.white,
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
                                                        if (state
                                                            is ImageUploadInitial) {
                                                          return const Center(
                                                            child: Text(
                                                              "upload image first",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        } else if (state
                                                            is ImageUploadLoading) {
                                                          return const Center(
                                                            child: Text(
                                                              "Uploading....",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        } else if (state
                                                            is ImageUploadSuccess) {
                                                          return SizedBox(
                                                            height: 45,
                                                            width:
                                                                double.infinity,
                                                            child: ElevatedButton(
                                                              style:
                                                                  ElevatedButton
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
                                                              onPressed:
                                                                  () async {
                                                                if (titleController.text.isEmpty ||
                                                                    amountController
                                                                        .text
                                                                        .isEmpty ||
                                                                    descriptionController
                                                                        .text
                                                                        .isEmpty) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          const SnackBar(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(20))),
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating,
                                                                    width: 300,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content: Text(
                                                                        "Please fill all the fields"),
                                                                  ));
                                                                } else {
                                                                  await FirebaseJob()
                                                                      .createJob(
                                                                    job: Job(
                                                                      name: titleController
                                                                          .text,
                                                                      description:
                                                                          descriptionController
                                                                              .text,
                                                                      image: state
                                                                          .imageUrl,
                                                                      location:
                                                                          await SharedPreferencesManager()
                                                                              .getUserLocation(),
                                                                      createdAt:
                                                                          DateTime
                                                                              .now(),
                                                                      amount:
                                                                          amountController
                                                                              .text,
                                                                      belongsTo: FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid,
                                                                    ),
                                                                    context:
                                                                        context,
                                                                  );
                  
                                                                  titleController
                                                                      .clear();
                                                                  descriptionController
                                                                      .clear();
                                                                  amountController
                                                                      .clear();
                                                                  locationController
                                                                      .clear();
                                                                  locationController
                                                                      .clear();
                                                                }
                                                              },
                                                              child: Center(
                                                                child: Text(
                                                                  "Post",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .copyWith(
                                                                        color: Colors
                                                                            .white,
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
                                                                color:
                                                                    Colors.white),
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
                  )
                  : _selectedIndex == 1
                      ? const Expanded(child: SecondPage())
                      : const Expanded(flex: 5,child: ThirdPage()),
            ],
          )),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
}
