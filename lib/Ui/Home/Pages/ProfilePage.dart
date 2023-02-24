import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobsy_flutter/Ui/Authentication/Widget/InputField.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/JobsCard.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ProfilesJobCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final locationController = TextEditingController();
  final roleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        body: SafeArea(
            child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Profile",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          //profile details
                          Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage("lib/Assets/bulb.jpg"),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Emilio Kariuki",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "emilio113kariuki@gmail.com",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          "0796250443",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum sapien ac elit lobortis, vitae rutrum ipsum tincidunt. Aenean interdum convallis leo in tempor. Duis lacinia tellus nisl, at faucibus ante convallis quis. Aliquam eucongue elit, a placerat metus. Phasellus pellentesque, odio eget auctor bibendum, ligula nulla fermentum mi, non consectetur sem metus ac sapien. Pellentesque vestibulum magna eu nisi blandit semper. Phasellus magna ligula, commodo at vulputate in, efficitur at elit. Mauris laoreet nibh vitae sem varius, sed egestas velit gravida. Vestibulum condimentum pharetra ipsum, eget placerat purus semper nec. Phasellus vestibulum nulla lacinia turpis rhoncus tincidunt. Aliquam erat volutpat.""",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),

                          //location
                          Positioned.fill(
                            top: 10,
                            right: 10,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.white54,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Nairobi, Kenya",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: Colors.white54,
                                            fontSize: 11),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Scaffold(
                      backgroundColor: bgColor,
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Jobs Posted",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                        color: bgColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('job')
                                            .where("belongsTo",
                                                isEqualTo: FirebaseAuth
                                                    .instance.currentUser!.uid)
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
                                                    color: Colors.white),
                                              ),
                                            );
                                          }

                                          if (!snapshot.hasData) {
                                            out = const Center(
                                              child: Text(
                                                "No data",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            out = const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            final docs = snapshot.data!.docs;
                                            out = ListView.builder(
                                              itemCount: docs.length,
                                              // shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                Map<String, dynamic> data =
                                                    docs[index].data()
                                                        as Map<String, dynamic>;

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ProfileJobCard(
                                                    collection: "job",
                                                    jobId: docs[index].id ,
                                                    image: data['image'],
                                                    sender: "Emilio kariuki",
                                                    role: "Developer",
                                                    title: data['name'] ??
                                                        "No title",
                                                    description:
                                                        data['description'] ??
                                                            "",
                                                    amount:
                                                        data['amount'] ?? "0",
                                                    location:
                                                        data['location'] ??
                                                            "No location",
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                          return out;
                                        })),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Favourites",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    decoration: BoxDecoration(
                                        color: bgColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('favourite')
                                            .where(
                                              "belongsTo",
                                              isEqualTo: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                            )
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
                                                    color: Colors.white),
                                              ),
                                            );
                                          }

                                          if (!snapshot.hasData) {
                                            out = const Center(
                                              child: Text(
                                                "No data",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          }
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            out = const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (snapshot.hasData) {
                                            final docs = snapshot.data!.docs;
                                            out = ListView.builder(
                                              itemCount: docs.length,
                                              // shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                Map<String, dynamic> data =
                                                    docs[index].data()
                                                        as Map<String, dynamic>;

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: ProfileJobCard(
                                                    collection: "favourite",
                                                    jobId: docs[index].id,
                                                    image: data['image'],
                                                    sender: "Emilio kariuki",
                                                    role: "Developer",
                                                    title: data['name'] ??
                                                        "No title",
                                                    description:
                                                        data['description'] ??
                                                            "",
                                                    amount:
                                                        data['amount'] ?? "0",
                                                    location:
                                                        data['location'] ??
                                                            "No location",
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
                      ),
                    ),
                  ),
                )
              ],
            ),

            //edit profile
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 55),
                padding: const EdgeInsets.all(20),
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputField(
                      controller: nameController,
                      hintText: "name",
                      title: "Name",
                      different: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      controller: phoneController,
                      hintText: "phone",
                      title: "Phone",
                      different: false,
                    ),
                    InputField(
                      controller: roleController,
                      hintText: "role",
                      title: "Role",
                      different: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      controller: locationController,
                      hintText: "location",
                      title: "Location",
                      different: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Bio",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: bioController,
                      obscureText: false,
                      cursorColor: Colors.white,
                      enabled: true,
                      maxLines: 6,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                      decoration: InputDecoration(
                        fillColor: secondaryColor,
                        filled: true,
                        hintText: "bio",
                        hintStyle:
                            Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Colors.white54,
                                  fontWeight: FontWeight.w400,
                                ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(74, 77, 84, 0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          //gapPadding: 16,
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if (nameController.text.isEmpty ||
                              phoneController.text.isEmpty ||
                              roleController.text.isEmpty ||
                              bioController.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              behavior: SnackBarBehavior.floating,
                              width: 300,
                              backgroundColor: Colors.red,
                              content: Text("Please fill all the fields"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                width: 300,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                backgroundColor: greenColor,
                                content: Text(
                                  "Job posted successfully",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            setState(() {});
                          }
                        },
                        child: Center(
                          child: Text(
                            "Update",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )));
  }
}

class JobUserCard extends StatelessWidget {
  const JobUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "lib/Assets/manyColors.jpg",
                height: 130,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              const Positioned.fill(
                  child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 20,
                  ),
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
                          const CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage("lib/Assets/bulb.jpg"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Emilio Kariuki",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                "developer",
                                style: TextStyle(
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
                  children: const [
                    Text(
                      "Content Writing",
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "\$${400}",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 55,
                  child: Text(
                    """My interest in the GitHub Campus Expert program stems from my desire to empower other students to become more involved in the open-source community and to help them develop the skills and confidence they need to contribute to projects. I firmly believe that open-source software is the future of the tech industry, and I am excited about the opportunity to be a part of a community that shares this vision.
                In addition to my technical skills, I have excellent communication and leadership skills that I have developed through various leadership roles within the GDSC community, including organizing hackathons, webinars, and workshops. """,
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white54,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Nairobi, Kenya",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white54, fontSize: 11),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: SizedBox(
                //         height: 35,
                //         width: double.infinity,
                //         child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: primaryColor,
                //             // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(5),
                //             ),
                //           ),
                //           onPressed: () {},
                //           child: Center(
                //             child: Text(
                //               "Post",
                //               style:
                //                   Theme.of(context).textTheme.bodyLarge!.copyWith(
                //                         color: Colors.white,
                //                       ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 20,),
                //     Expanded(
                //       child: SizedBox(
                //         height: 35,
                //         width: double.infinity,
                //         child: ElevatedButton(
                //           style: ElevatedButton.styleFrom(
                //             backgroundColor: primaryColor,
                //             // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(5),
                //             ),
                //           ),
                //           onPressed: () {},
                //           child: Center(
                //             child: Text(
                //               "Post",
                //               style:
                //                   Theme.of(context).textTheme.bodyLarge!.copyWith(
                //                         color: Colors.white,
                //                       ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
