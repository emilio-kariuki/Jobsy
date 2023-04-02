import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Firebase/Job.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ClaimedJobsCard.dart';

class ClaimedJobs extends StatelessWidget {
  const ClaimedJobs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 5),
        child: FutureBuilder(
          future: FirebaseJob()
              .getClaimedJobs(userId: FirebaseAuth.instance.currentUser!.uid),
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
                  "No claimed jobs",
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
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.7,
                child: ListView.builder(
                  itemCount: docs!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ClaimedJobsCard(
                        collection: "favourite",
                        claimedBy: docs[index].appliedBy ?? "",
                        index: index,
                        jobId: "",
                        image: docs[index].image,
                        sender: "Emilio kariuki",
                        role: "Developer",
                        title: docs[index].name,
                        description: docs[index].description,
                        amount: docs[index].amount,
                        location: docs[index].location,
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
