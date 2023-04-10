import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/Favourite/favourites_bloc.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Model/UserModel.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:url_launcher/url_launcher.dart';

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
        child: 
Column(
          children: [
            ImageNetwork(
              image: image,
              height: 150,
              width: 250,
              duration: 10,
              onPointer: true,
              debugPrint: false,
              fullScreen: false,
              borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)
              ),
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
                      maxLines:4,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Semantics(
                    button: true,
                    child: InkWell(
                      onTap: () async{
                         String url = "mail:emilio113kariuki@gmail.com";
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            throw 'Could not launch $url';
                          }
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 200,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text("Contact",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                      ),
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

