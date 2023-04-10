import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/Favourite/favourites_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Model/JobDetailsModel.dart';
import 'package:jobsy_flutter/Model/UserModel.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:keep_keyboard_popup_menu/keep_keyboard_popup_menu.dart';

enum menuValues { edit, delete }

class ClaimedJobsCard extends StatelessWidget {
  final String image;
  final String sender;
  final String role;
  final String title;
  final String amount;
  final String description;
  final String location;
  final String jobId;
  final String collection;
  final String claimedBy;
  int index;
  ClaimedJobsCard(
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
      required this.claimedBy});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesBloc(),
      child: Container(
        // padding: const EdgeInsets.only(),
        height: 250,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(5),
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
              onError: const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      "Claimed by: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white54, fontSize: 11),
                    ),
                    FutureBuilder<UserModel>(
                        future:
                            FirebaseAuthentication().getUser(userId: claimedBy),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white, fontSize: 11),
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                  ]),

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
                      const Text(
                        "\$",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: Text(
                      description,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Text("Assign",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                  ),

                  // Row(
                  //   children: [
                  //     const Icon(
                  //       Icons.location_on,
                  //       color: Colors.white54,
                  //       size: 15,
                  //     ),
                  //     const SizedBox(
                  //       width: 5,
                  //     ),
                  //     Text(
                  //       location,
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .bodyLarge!
                  //           .copyWith(color: Colors.white54, fontSize: 11),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
