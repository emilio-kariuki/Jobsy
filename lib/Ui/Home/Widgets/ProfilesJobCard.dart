import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/Favourite/favourites_bloc.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:keep_keyboard_popup_menu/keep_keyboard_popup_menu.dart';

enum menuValues { edit, delete }

class ProfileJobCard extends StatelessWidget {
  final String image;
  final String sender;
  final String role;
  final String title;
  final String amount;
  final String description;
  final String location;
  final String jobId;
  final String collection;
  int index;
  ProfileJobCard(
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
      this.index = 0});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesBloc(),
      child: Container(
        // padding: const EdgeInsets.only(),
        width: MediaQuery.of(context).size.width / 5,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ImageNetwork(
                  image: image,
                  height: 130,
                  width: MediaQuery.of(context).size.width / 4,
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
                    debugPrint("©gabriel_patrick_souza");
                  },
                ),
                Positioned.fill(
                    top: 10,
                    right: 10,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: BlocBuilder<FavouritesBloc, FavouritesState>(
                        builder: (context, state) {
                          return PopupMenuButton<menuValues>(
                            color: bgColor,
                            onSelected: (value) {
                              switch (value) {
                                case menuValues.delete:
                                  BlocProvider.of<FavouritesBloc>(context)
                                      .add(FavouriteRemoved(index: index));

                                  break;
                                case menuValues.edit:
                                  debugPrint("Edit");
                                  break;
                              }
                            },
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: menuValues.edit,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const PopupMenuItem(
                                value: menuValues.delete,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ))
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
                              backgroundImage: NetworkImage(image),
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
                        title,
                        overflow: TextOverflow.clip,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "\$",
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
                      description,
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
