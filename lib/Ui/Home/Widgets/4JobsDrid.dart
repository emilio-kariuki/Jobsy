import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/ApplyJob/apply_job_bloc.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/JobModel.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/JobsCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';

import '../../../Blocs/ShowDetails/show_details_bloc.dart';

class JobsGrid extends StatelessWidget {
  const JobsGrid({super.key});

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: const [
              SizedBox(height: 30, child: CircularProgressIndicator()),
              SizedBox(width: 20),
              Text("Loading"),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShowDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => ApplyJobBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return StreamBuilder(
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.9,
                              crossAxisCount: Responsive.isDesktop(context)
                                  ? (state is ShowDetailsInitial ? 5 : 2)
                                  : state is ShowDetailsInitial
                                      ? 4
                                      : 2,
                            ),
                            
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data =
                                  docs[index].data() as Map<String, dynamic>;

                              return JobCard(
                                jobId: docs[index].id,
                                belongsTo: data['belongsTo'] ?? "",
                                image: data['image'],
                                sender: "Emilio kariuki",
                                role: "Developer",
                                title: data['name'] ?? "No title",
                                description: data['description'] ?? "",
                                amount: data['amount'] ?? "0",
                                location: data['location'] ?? "No location",
                                userImage: data['userImage'] ?? "",
                                userName: data['userName'] ?? "",
                                userRole: data['userRole'] ?? "",
                                time: data['createdAt'] ?? "",
                              );
                            },
                          ),
                        ),
                        state is ShowDetailsLoaded
                            ? Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: double.infinity,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              ImageNetwork(
                                                image: state.job.image,
                                                height: 250,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      width: 30,
                                                      height: 30,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 4,
                                                              right: 4),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
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
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        ImageNetwork(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          image: state
                                                              .job.userImage,
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
                                                          onTap: () {},
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              state
                                                                  .job.userName,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 17),
                                                            ),
                                                            const SizedBox(
                                                              height: 1,
                                                            ),
                                                            Text(
                                                              state
                                                                  .job.userRole,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white54,
                                                                  fontSize: 13),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      // ignore: unrelated_type_equality_checks
                                                      Timestamp.now()
                                                                  .toDate()
                                                                  .difference(state
                                                                      .job
                                                                      .createdAt
                                                                      .toDate())
                                                                  .inDays ==
                                                              0
                                                          ? "Today"
                                                          : Timestamp.now()
                                                                      .toDate()
                                                                      .difference(state
                                                                          .job
                                                                          .createdAt
                                                                          .toDate())
                                                                      .inDays ==
                                                                  1
                                                              ? "Yesterday"
                                                              : "//${Timestamp.now().toDate().difference(state.job.createdAt.toDate()).inDays} days ago",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color: Colors
                                                                  .white54,
                                                              fontSize: 11),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      state.job.name,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18),
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
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                BlocBuilder<ApplyJobBloc,
                                                    ApplyJobState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is ApplyJobSuccess) {
                                                      
                                                      _onWidgetDidBuild(
                                                          () async {
                                                            
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            content: const Text(
                                                                "Applied job successfully"),
                                                            backgroundColor:
                                                                Colors.green,
                                                          ),
                                                        );
                                                        Navigator.of(context);
                                                      });
                                                    } else if (state
                                                        is ApplyJobFailure) {
                                                      Navigator.pop(context);
                                                      _onWidgetDidBuild(
                                                          () async {
                                                            Navigator.of(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                            content: Text(
                                                                state.error),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        );
                                                      });
                                                    }
                                                    if (state
                                                        is ApplyJobLoading) {
                                                      _onWidgetDidBuild(() {
                                                        showLoadingDialog(
                                                            context);
                                                      });
                                                    }
                                                    return const SizedBox();
                                                  },
                                                ),
                                                Center(
                                                  child: SizedBox(
                                                    height: 45,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
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
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        state.job.belongsTo !=
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid
                                                            ? BlocProvider.of<
                                                                        ApplyJobBloc>(
                                                                    context)
                                                                .add(
                                                                    ApplyButtonPressed(
                                                                userId: FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid,
                                                                name: state
                                                                    .job.name,
                                                                description: state
                                                                    .job
                                                                    .description,
                                                                amount: state
                                                                    .job.amount,
                                                                location: state
                                                                    .job
                                                                    .location,
                                                                image: state
                                                                    .job.image,
                                                                createdAt: state
                                                                    .job
                                                                    .createdAt,
                                                                userImage: state
                                                                    .job
                                                                    .userImage,
                                                                userName: state
                                                                    .job
                                                                    .userName,
                                                                userRole: state
                                                                    .job
                                                                    .userRole,
                                                                belongsTo: state
                                                                    .job
                                                                    .belongsTo,
                                                              ))
                                                            : Container();

                                                        state.job.belongsTo !=
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid
                                                            ? await FirebaseJob()
                                                            .applyJob(
                                                          appliedBy:
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                          userId: state
                                                              .job.belongsTo,
                                                          job: Job(
                                                            name:
                                                                state.job.name,
                                                            description: state
                                                                .job
                                                                .description,
                                                            amount: state
                                                                .job.amount,
                                                            location: state
                                                                .job.location,
                                                            image:
                                                                state.job.image,
                                                            createdAt: state
                                                                .job.createdAt,
                                                            userImage: state
                                                                .job.userImage,
                                                            userName: state
                                                                .job.userName,
                                                            userRole: state
                                                                .job.userRole,
                                                            belongsTo: state
                                                                .job.belongsTo,
                                                          ),
                                                        ) : Container();
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          "Apply",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Similar",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.4,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('job')
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
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    );
                                                  }

                                                  if (!snapshot.hasData) {
                                                    out = const Center(
                                                      child: Text(
                                                        "No data",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    );
                                                  }
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    out = const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                  if (snapshot.hasData) {
                                                    final docs =
                                                        snapshot.data!.docs;
                                                    out = ListView.builder(
                                                      itemCount: docs.length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemBuilder:
                                                          (context, index) {
                                                        Map<String, dynamic>
                                                            data =
                                                            docs[index].data()
                                                                as Map<String,
                                                                    dynamic>;

                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: JobCard(
                                                            jobId:
                                                                docs[index].id,
                                                            image: data[
                                                                    'image'] ??
                                                                "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                                                            sender:
                                                                "Emilio kariuki",
                                                            role: "Developer",
                                                            title:
                                                                data['name'] ??
                                                                    "No title",
                                                            description: data[
                                                                    'description'] ??
                                                                "",
                                                            amount: data[
                                                                    'amount'] ??
                                                                "0",
                                                            location: data[
                                                                    'location'] ??
                                                                "No location",
                                                            userName: data[
                                                                    'userName'] ??
                                                                "No name",
                                                            belongsTo: data[
                                                                    'belongsTo'] ??
                                                                "No belongs to",
                                                            userRole: data[
                                                                    'userRole'] ??
                                                                "No role",
                                                            time: data[
                                                                    'createdAt'] ??
                                                                Timestamp.now(),
                                                            userImage: data[
                                                                    'userImage'] ??
                                                                "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                  return out;
                                                })),
                                      ),
                                    ],
                                  ),
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
            });
      }),
    );
  }
}
