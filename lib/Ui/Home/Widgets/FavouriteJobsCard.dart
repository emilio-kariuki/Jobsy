import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/Favourite/favourites_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Model/UserModel.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

enum menuValues { delete }

class FavouriteJobCard extends StatelessWidget {
  final String image;
  final String sender;
  final String role;
  final String title;
  final String amount;
  final String description;
  final String location;
  final String jobId;
  final String collection;
  final String userImage;
  final String userRole;
  final String userName;
  final String belongsTo;
  int index;
  FavouriteJobCard(
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
      required this.userImage,
      required this.userRole,
      required this.userName,
      required this.belongsTo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesBloc(),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
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
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              onError: const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                return showDialog<void>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                image: userImage,
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
                                                userName,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                userRole,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              FutureBuilder<UserModel>(
                                                  future:
                                                      FirebaseAuthentication()
                                                          .getUser(
                                                              userId:
                                                                  belongsTo),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Text(
                                                        snapshot.data?.bio ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
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
                                image: userImage,
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
                                  sender,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  role,
                                  style: const TextStyle(
                                      color: Colors.white54, fontSize: 11),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      PopupMenuButton<menuValues>(
                        color: bgColor,
                        onSelected: (value) {
                          switch (value) {
                            case menuValues.delete:
                              FirebaseJob().deleteFavouriteJob(index: index);

                              break;
                            
                          }
                        },
                        child: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 20,
                        ),
                        itemBuilder: (context) => [
                          
                          const PopupMenuItem(
                            value: menuValues.delete,
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
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
                        title,
                        overflow: TextOverflow.clip,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                       Text(
                        "\$$amount",
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
