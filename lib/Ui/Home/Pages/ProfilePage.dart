import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/Get%20User/get_user_bloc.dart';
import 'package:jobsy_flutter/Blocs/UploadImage/image_upload_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Ui/Authentication/Widget/InputField.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ClaimedJobsCard.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/JobsCard.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ProfilesJobCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

class SecondPage extends StatefulWidget {
  final PageController pageController;
  const SecondPage({super.key, required this.pageController});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final locationController = TextEditingController();
  final roleController = TextEditingController();
  String? amountEarned;
  String? image;
  String? email;
  String? name;

  @override
  void initState() {
    super.initState();

    FirebaseAuthentication()
        .getUser(userId: FirebaseAuth.instance.currentUser!.uid)
        .then((value) async {
      nameController.text = value.name;
      phoneController.text = value.phone ?? "";
      bioController.text = value.bio ?? "";
      locationController.text = value.location ?? "";
      roleController.text = value.role ?? "";
      amountEarned = value.amountEarned ?? "";
      image = value.image ?? "";
      email = value.email;
      name = value.name;

      await SharedPreferencesManager()
          .setUserLocation(value: value.location ?? "");
      await SharedPreferencesManager().setUserPhone(value: value.phone ?? "");
      await SharedPreferencesManager().setRole(value: value.role ?? "");
      await SharedPreferencesManager().setUserImage(value: value.image ?? "");
      await SharedPreferencesManager().setUserName(value: value.name);
      await SharedPreferencesManager().setUserEmail(value: value.email);
      print(await SharedPreferencesManager().getUserLocation());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetUserBloc()
            ..add(GetUser(userId: FirebaseAuth.instance.currentUser!.uid)),
        ),
        BlocProvider(
          create: (context) => ImageUploadBloc(),
        ),
      ],
      child: Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
                child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                widget.pageController.animateToPage(0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Profile",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<ImageUploadBloc, ImageUploadState>(
                            builder: (context, state) {
                              return BlocBuilder<GetUserBloc, GetUserState>(
                                builder: (context, state) {
                                  if (state is GetUserLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is GetUserLoaded) {
                                    return Stack(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: bgColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  state is ImageUploadLoading
                                                      ? const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child:
                                                              CircularProgressIndicator(),
                                                        )
                                                      : ImageNetwork(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          image: state
                                                                  .user.image ??
                                                              "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                                                          height: 50,
                                                          width: 50,
                                                          duration: 10,
                                                          onPointer: true,
                                                          debugPrint: false,
                                                          fullScreen: false,
                                                          onLoading:
                                                              const CircularProgressIndicator(
                                                            color: Colors
                                                                .indigoAccent,
                                                          ),
                                                          onError: const Icon(
                                                            Icons.error,
                                                            color: Colors.red,
                                                          ),
                                                          onTap: () async {
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
                                                                  UpdateProfile(
                                                                      image:
                                                                          files,
                                                                      path: files
                                                                          .name),
                                                                );
                                                              });
                                                            });
                                                          },
                                                        ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        state.user.name,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        state.user.email,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Text(
                                                        state.user.phone ??
                                                            "07000000000",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                state.user.bio ?? "Bio",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned.fill(
                                          top: 10,
                                          right: 10,
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  color: Colors.white54,
                                                  size: 15,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  state.user.location ??
                                                      "Location",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          color: Colors.white54,
                                                          fontSize: 11),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  } else if (state is GetUserError) {
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  } else {
                                    return const Center(
                                      child: Text("Error"),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Jobs Posted",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.45,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      decoration: BoxDecoration(
                                          color: bgColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('job')
                                              .where("belongsTo",
                                                  isEqualTo: FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            var out;
                                            if (snapshot.hasError) {
                                              out = const Center(
                                                child: Text(
                                                  "Something went wrong",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }

                                            if (!snapshot.hasData) {
                                              out = const Center(
                                                child: Text(
                                                  "No data",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              out = const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            if (snapshot.hasData) {
                                              final docs = snapshot.data!.docs;
                                              out = ListView.builder(
                                                itemCount: docs.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  Map<String, dynamic> data =
                                                      docs[index].data() as Map<
                                                          String, dynamic>;

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: ProfileJobCard(
                                                      collection: "job",
                                                      jobId: docs[index].id,
                                                      image: data['image'] ??
                                                          "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                                                      sender: "Emilio kariuki",
                                                      role: "Developer",
                                                      title: data['name'] ??
                                                          "No title",
                                                      description:
                                                          data['description'] ??
                                                              "",
                                                      amount:
                                                          data['amount'] ?? "0",
                                                      location:
                                                          data['location'] ??
                                                              "No location",
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                            return out;
                                          })),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Favourites",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: FutureBuilder(
                                      future: FirebaseJob().getFavourites(
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid),
                                      builder: (context, snapshot) {
                                        var out;
                                        if (snapshot.hasError) {
                                          out = const Center(
                                            child: Text(
                                              "Something went wrong",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }

                                        if (!snapshot.hasData) {
                                          out = const Center(
                                            child: Text(
                                              "No data",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          out = const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          final docs = snapshot.data;
                                          out = SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: ListView.builder(
                                              itemCount: docs!.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ProfileJobCard(
                                                    collection: "favourite",
                                                    index: index,
                                                    jobId: "",
                                                    image: docs[index].image,
                                                    sender: "Emilio kariuki",
                                                    role: "Developer",
                                                    title: docs[index].name,
                                                    description:
                                                        docs[index].description,
                                                    amount: docs[index].amount,
                                                    location:
                                                        docs[index].location,
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return out;
                                      },
                                    )),

                                //applied jobs
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Applied jobs",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: FutureBuilder(
                                      future: FirebaseJob().getAppliedJobs(
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid),
                                      builder: (context, snapshot) {
                                        var out;
                                        if (snapshot.hasError) {
                                          out = const Center(
                                            child: Text(
                                              "Something went wrong",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }

                                        if (!snapshot.hasData) {
                                          out = const Center(
                                            child: Text(
                                              "No data",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          out = const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          final docs = snapshot.data;
                                          out = SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: ListView.builder(
                                              itemCount: docs!.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ProfileJobCard(
                                                    collection: "favourite",
                                                    index: index,
                                                    jobId: "",
                                                    image: docs[index].image,
                                                    sender: "Emilio kariuki",
                                                    role: "Developer",
                                                    title: docs[index].name,
                                                    description:
                                                        docs[index].description,
                                                    amount: docs[index].amount,
                                                    location:
                                                        docs[index].location,
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return out;
                                      },
                                    )),
                                const Text(
                                  "Claimed jobs",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: FutureBuilder(
                                      future: FirebaseJob().getClaimedJobs(
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid),
                                      builder: (context, snapshot) {
                                        var out;
                                        if (snapshot.hasError) {
                                          out = const Center(
                                            child: Text(
                                              "Something went wrong",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }

                                        if (!snapshot.hasData) {
                                          out = const Center(
                                            child: Text(
                                              "No claimed jobs",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          out = const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          final docs = snapshot.data;
                                          out = SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.45,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                            child: ListView.builder(
                                              itemCount: docs!.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ClaimedJobsCard(
                                                    collection: "favourite",
                                                    claimedBy:
                                                        docs[index].appliedBy ??
                                                            "",
                                                    index: index,
                                                    jobId: "",
                                                    image: docs[index].image,
                                                    sender: "Emilio kariuki",
                                                    role: "Developer",
                                                    title: docs[index].name,
                                                    description:
                                                        docs[index].description,
                                                    amount: docs[index].amount,
                                                    location:
                                                        docs[index].location,
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                        return out;
                                      },
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                //edit profile
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 55),
                    padding: const EdgeInsets.all(20),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                  ),
                          decoration: InputDecoration(
                            fillColor: secondaryColor,
                            filled: true,
                            hintText: "bio",
                            hintStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
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
                                  "userId":
                                      FirebaseAuth.instance.currentUser!.uid,
                                  "createdAt": DateTime.now().toString(),
                                }).then((value) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
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
                )
              ],
            )),
          )),
    );
  }
}
