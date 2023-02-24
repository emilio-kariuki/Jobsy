import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/ShowDetails/show_details_bloc.dart';
import 'package:jobsy_flutter/Blocs/ShowPost/show_post_bloc.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/JobModel.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

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
  const JobCard(
      {super.key,
      required this.image,
      required this.sender,
      required this.role,
      required this.title,
      required this.amount,
      required this.description,
      required this.location,
      required this.jobId});

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
        width: MediaQuery.of(context).size.width * 0.15,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Expanded(
                  child: BlocBuilder<ShowDetailsBloc, ShowDetailsState>(
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
                ),
                BlocBuilder<FavouritesBloc, FavouritesState>(
                  builder: (context, state) {
                    return Positioned.fill(
                        child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<FavouritesBloc>(context)
                                .add(FavouriteAdded(
                                    job: Job(
                                      name: widget.title,
                                      description: widget.description,
                                      image: widget.image,
                                      location: widget.location,
                                      createdAt: DateTime.now(),
                                      amount: widget.amount,
                                      belongsTo: FirebaseAuth
                                          .instance.currentUser!.uid,
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
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 17,
                              backgroundImage: NetworkImage(widget.image),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.sender,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  widget.role,
                                  style: const TextStyle(
                                      color: Colors.white54, fontSize: 11),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Text(
                        "2 days ago",
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
