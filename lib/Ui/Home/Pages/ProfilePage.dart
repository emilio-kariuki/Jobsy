import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsy_flutter/Blocs/Get%20User/get_user_bloc.dart';
import 'package:jobsy_flutter/Blocs/UploadImage/image_upload_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/AppliedJobs.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ClaimedJobs.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/EditProfile.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/FavouriteJobs.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/PostedJobs.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ProfileChanger.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
                child: Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  // GestureDetector(
                                  //     onTap: () {
                                  //       widget.pageController.animateToPage(0,
                                  //           duration:
                                  //               const Duration(milliseconds: 500),
                                  //           curve: Curves.easeInOut);
                                  //     },
                                  //     child: const Icon(
                                  //       Icons.arrow_back_ios,
                                  //       color: Colors.white,
                                  //       size: 20,
                                  //     )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ProfileChanger(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Jobs Posted",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  PostedJobs(context: context),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Favourites",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const FavouriteJobs(),

                                  //applied jobs
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Applied jobs",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const AppliedJobs(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Claimed jobs",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const ClaimedJobs(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                //edit profile
                const SizedBox(
                  width: 10,
                ),
                EditProfile(
                    nameController: nameController,
                    phoneController: phoneController,
                    roleController: roleController,
                    locationController: locationController,
                    bioController: bioController,
                    amountEarned: amountEarned,
                    image: image)
              ],
            )),
          )),
    );
  }
}
