import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/ShowDetails/show_details_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Model/JobDetailsModel.dart';
import 'package:jobsy_flutter/Model/UserModel.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/SharedPreferenceManager.dart';

import '../../../Blocs/Favourite/favourites_bloc.dart';

class JobCard extends StatefulWidget {
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

  final String amount;
  final String belongsTo;
  final String description;
  final String image;
  final String jobId;
  final String location;
  final String role;
  final String sender;
  final Timestamp time;
  final String title;
  final String userImage;
  final String userName;
  final String userRole;

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
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
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
                  imageCache: CachedNetworkImageProvider(widget.image),
                );

                // return CachedNetworkImage(
                //   height: 130,
                //   width: MediaQuery.of(context).size.width / 4,
                //   imageUrl: widget.image,
                //   fit: BoxFit.cover,
                //   imageBuilder: (context, imageProvider) {
                //     return Container(
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //           image: imageProvider,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     );
                //   },
                //   placeholder: (context, url) => const Center(
                //     child: CircularProgressIndicator(
                //       strokeWidth: 3,
                //     ),
                //   ),
                //   errorWidget: (context, url, error) => const Icon(
                //     Icons.error,
                //     color: Colors.red,
                //     size: 18,
                //   ),
                // );
              },
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
                          GestureDetector(
                            onTap: () async {
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
                                                    .getUser(
                                                        userId:
                                                            widget.belongsTo),
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
                            child: ImageNetwork(
                              image: widget.userImage,
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
                      Column(
                        children: [
                          Text(
                            widget.title,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\$${widget.amount}",
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 12),
                          )
                        ],
                      ),
                      BlocBuilder<FavouritesBloc, FavouritesState>(
                        builder: (context, state) {
                          return Padding(
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
                                      userName:
                                          await SharedPreferencesManager()
                                              .getUserName(),
                                      userRole:
                                          await SharedPreferencesManager()
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
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: Text(
                      widget.description,
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
            ),
          ],
        ),
      ),
    );
  }
}
