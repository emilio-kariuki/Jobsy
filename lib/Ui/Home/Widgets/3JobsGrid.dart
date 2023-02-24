import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsy_flutter/Ui/Home/HomePage.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/JobsCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';

import '../../../Blocs/ShowDetails/show_details_bloc.dart';

class Jobs3Grid extends StatelessWidget {
  const Jobs3Grid({super.key});

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
              out = Expanded(
                child: GridView.builder(
                  itemCount: docs.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    crossAxisCount: Responsive.isDesktop(context) ? 4 : 3,
                  ),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        docs[index].data() as Map<String, dynamic>;
                    return JobCard(
                      jobId: docs[index].id,
                      image: data['image'],
                      sender: "Emilio kariuki",
                      role: "Developer",
                      title: data['name'],
                      description: data['description'] ?? "",
                      amount: data['amount'],
                      location: data['location'],
                      userImage: data['userImage'] ?? "",
                      userName: data['userName'] ?? "",
                      userRole: data['userRole'] ?? "",
                      time: data['createdAt'] ?? "",
                    );
                  },
                ),
              );
            }
            return out;
          }),
    );
  }
}
