import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/FavouriteJobsCard.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/PostedJobsCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

enum menuValues {delete }

class FavouriteJobs extends StatefulWidget {
  const FavouriteJobs({
    super.key,
  });

  @override
  State<FavouriteJobs> createState() => _FavouriteJobsState();
}

class _FavouriteJobsState extends State<FavouriteJobs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: FutureBuilder(
          future: FirebaseJob()
              .getFavourites(userId: FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
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
              final docs = snapshot.data;
              out = SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ListView.builder(
                  itemCount: docs!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FavouriteJobCard(
                        userImage: docs[index].userImage,
                        userName: docs[index].userName,
                        userRole: docs[index].userRole,
                        belongsTo: docs[index].belongsTo,
                        index: index,
                        jobId: "",
                        image: docs[index].image,
                        sender: "Emilio kariuki",
                        role: "Developer",
                        title: docs[index].name,
                        description: docs[index].description,
                        amount: docs[index].amount,
                        location: docs[index].location,
                        collection: '',
                      ),
                    );
                  },
                ),
              );
            }
            return out;
          },
        ));
  }
}
