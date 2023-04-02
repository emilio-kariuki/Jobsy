import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/PostedJobsCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

enum menuValues { edit, delete }

class PostedJobs extends StatelessWidget {
  const PostedJobs({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(10)),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('job')
                  .where("belongsTo",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
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
                  out = ListView.builder(
                    itemCount: docs.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data =
                          docs[index].data() as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: MyJobsCard(
                          time: data['createdAt'] ?? "No time",
                          userImage: data['userImage'],
                          userName: data['userName'] ?? "No name",
                          userRole: data['userRole'] ?? "No role",
                          belongsTo: data['belongsTo'],
                          collection: "job",
                          jobId: docs[index].id,
                          image: data['image'],
                          sender: "Emilio kariuki",
                          role: "Developer",
                          title: data['name'] ?? "No title",
                          description: data['description'] ?? "",
                          amount: data['amount'] ?? "0",
                          location: data['location'] ?? "No location",
                          id: docs[index].id,
                        ),
                      );
                    },
                  );
                }
                return out;
              })),
    );
  }
}
