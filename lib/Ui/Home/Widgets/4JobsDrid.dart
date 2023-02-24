import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/Favourite/favourites_bloc.dart';
import 'package:jobsy_flutter/Ui/Home/HomePage.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/JobsCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';

import '../../../Blocs/ShowDetails/show_details_bloc.dart';

class JobsGrid extends StatelessWidget {
  const JobsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowDetailsBloc(),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('job').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var out;
            if (snapshot.hasError) {
              out = const Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (!snapshot.hasData) {
              out = const Center(
                child: Text(
                  "No data",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              out = const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              out = BlocBuilder<ShowDetailsBloc, ShowDetailsState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                          child: GridView.builder(
                        itemCount: docs.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10,
                          crossAxisCount: Responsive.isDesktop(context)
                              ? (state is ShowDetailsInitial ? 5 : 3)
                              : state is ShowDetailsInitial
                                  ? 4
                                  : 2,
                        ),
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              docs[index].data() as Map<String, dynamic>;

                          return JobCard(
                            jobId: docs[index].id,
                            image: data['image'],
                            sender: "Emilio kariuki",
                            role: "Developer",
                            title: data['name'] ?? "No title",
                            description: data['description'] ?? "",
                            amount: data['amount'] ?? "0",
                            location: data['location'] ?? "No location",
                          );
                        },
                      )),
                      state is ShowDetailsLoaded
                          ? Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ImageNetwork(
                                        image: state.job.image,
                                        height: 250,
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                        onTap: () {},
                                      ),
                                      Positioned.fill(
                                          top: 10,
                                          right: 10,
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              padding: const EdgeInsets.only(
                                                  bottom: 4, right: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: bgColor,
                                              ),
                                              child: Center(
                                                child: IconButton(
                                                  onPressed: () {
                                                    BlocProvider.of<
                                                                ShowDetailsBloc>(
                                                            context)
                                                        .add(
                                                            RemoveDetailsPressed());
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ImageNetwork(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: state.job.image,
                                              height: 30,
                                              width: 30,
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
                                              onTap: () {},
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "Emilio kariuki",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Text(
                                                  "Developer",
                                                  style: TextStyle(
                                                      color: Colors.white54,
                                                      fontSize: 11),
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
                                            .copyWith(
                                                color: Colors.white54,
                                                fontSize: 11),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.job.name,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        "\$${state.job.amount}",
                                        style: const TextStyle(
                                            color: Colors.white54,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.job.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: Colors.white54,
                                            fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        state.job.location,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                          // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () async {},
                                        child: Center(
                                          child: Text(
                                            "Apply",
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
                                  )
                                ],
                              ),
                            )
                          : state is ShowDetailsLoading
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: double.infinity,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Container(),
                    ],
                  );
                },
              );
            }
            return out;
          }),
    );
  }
}