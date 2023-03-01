import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/ShowDetails/show_details_bloc.dart';
import 'package:jobsy_flutter/Blocs/ShowPost/show_post_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/JobDetailsModel.dart';
import 'package:jobsy_flutter/Model/JobModel.dart';
import 'package:jobsy_flutter/Model/UserModel.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

import '../../../Blocs/Favourite/favourites_bloc.dart';

class JobCard extends StatefulWidget {
  final String image;
  final String sender;
  final String role;
  final String title;
  final String amount;
  final String description;
  final String location;
  final String jobId;
  final String userName;
  final String userImage;
  final String userRole;
  final Timestamp time;
  final String belongsTo;
  const JobCard(
      {super.key,
      required this.image,
      required this.sender,
      required this.role,
      required this.title,
      required this.amount,
      required this.description,
      required this.location,
      required this.jobId,
      required this.userName,
      required this.userImage,
      required this.userRole,
      required this.time,
      required this.belongsTo});

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FavouritesBloc(),
        ),
      ],
      child: Container(
        // padding: const EdgeInsets.only(),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                BlocBuilder<ShowDetailsBloc, ShowDetailsState>(
                  builder: (context, state) {
                    return ImageNetwork(
                      image: widget.image,
                      height: 130,
                      width: MediaQuery.of(context).size.width / 4,
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
                      onTap: () {
                        state is ShowDetailsInitial
                            ? BlocProvider.of<ShowDetailsBloc>(context)
                                .add(ShowDetailsPressed(id: widget.jobId))
                            : BlocProvider.of<ShowDetailsBloc>(context).add(
                                RemoveDetailsPressed(),
                              );
                      },
                    );
                  },
                ),
                BlocBuilder<FavouritesBloc, FavouritesState>(
                  builder: (context, state) {
                    return Positioned.fill(
                        child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            BlocProvider.of<FavouritesBloc>(context)
                                .add(FavouriteAdded(
                                    job: JobModel(
                                      name: widget.title,
                                      description: widget.description,
                                      image: widget.image,
                                      location: widget.location,
                                      createdAt: Timestamp.now(),
                                      amount: widget.amount,
                                      belongsTo: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      userImage:
                                          await SharedPreferencesManager()
                                              .getUserImage(),
                                      userName: await SharedPreferencesManager()
                                          .getUserName(),
                                      userRole: await SharedPreferencesManager()
                                          .getRole(),
                                    ),
                                    context: context));
                          },
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: state is FavouritesInitial ||
                                        state is FavouriteRemovedSuccess
                                    ? Colors.white
                                    : Colors.red,
                                size: 20,
                              )),
                        ),
                      ),
                    ));
                  },
                )
              ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ImageNetwork(
                            image: widget.userImage,
                            height: 30,
                            width: 30,
                            borderRadius: BorderRadius.circular(100),
                            duration: 10,
                            onPointer: true,
                            debugPrint: false,
                            fullScreen: false,
                            curve: Curves.bounceIn,
                            onLoading: const CircularProgressIndicator(
                              color: Colors.indigoAccent,
                            ),
                            onError: const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            onTap: () {
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                              image: widget.userImage,
                                              height: 40,
                                              width: 40,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              duration: 10,
                                              onPointer: true,
                                              debugPrint: false,
                                              fullScreen: false,
                                              curve: Curves.bounceIn,
                                              onLoading:
                                                  const CircularProgressIndicator(
                                                color: Colors.indigoAccent,
                                              ),
                                              onError: const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                              onTap: () {
                                                debugPrint(
                                                    "©gabriel_patrick_souza");
                                              },
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              widget.userName,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              widget.userRole,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            FutureBuilder<UserModel>(
                                                future: FirebaseAuthentication()
                                                    .getUser(userId: widget.belongsTo),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      snapshot.data?.bio ?? "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
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
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userName,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                widget.userRole,
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 11),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        // ignore: unrelated_type_equality_checks
                        Timestamp.now()
                                    .toDate()
                                    .difference(widget.time.toDate())
                                    .inDays ==
                                0
                            ? "Today"
                            : Timestamp.now()
                                        .toDate()
                                        .difference(widget.time.toDate())
                                        .inDays ==
                                    1
                                ? "Yesterday"
                                : "${Timestamp.now().toDate().difference(widget.time.toDate()).inDays} days ago",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white54, fontSize: 11),
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
                        widget.title, 
                        overflow: TextOverflow.clip,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "\$${widget.amount}",
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: Text(
                      """${widget.description}""",
                      overflow: TextOverflow.clip,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
