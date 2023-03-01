import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:jobsy_flutter/Blocs/Get%20User/get_user_bloc.dart';
import 'package:jobsy_flutter/Blocs/ShowPost/show_post_bloc.dart';
import 'package:jobsy_flutter/Repositories/Auth.dart';
import 'package:jobsy_flutter/Ui/Authentication/LoginPage.dart';
import 'package:jobsy_flutter/Ui/Home/Pages/ProfilePage.dart';
import 'package:jobsy_flutter/Ui/Home/Pages/About.dart';
import 'package:jobsy_flutter/Ui/Home/Pages/Home.dart';
import 'package:jobsy_flutter/Ui/Home/Widgets/ProfileCard.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  bool isDetails = false;
  String? name;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        name = value.data()!["name"];
      });
    });
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
  }

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShowPostBloc(),
        ),
        BlocProvider(
          create: (context) => GetUserBloc()
            ..add(GetUser(userId: FirebaseAuth.instance.currentUser!.uid)),
        ),
      ],
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0), // he
          child: AppBar(
            elevation: 0,
            backgroundColor: page.initialPage == 0 ?  bgColor:secondaryColor ,
            title: const Text(
              "Jbms",
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            leading: GestureDetector(
              onTap: (){
                page.animateToPage(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
              },
              child: Image.asset("lib/Assets/jobsy.jpeg", height: 40,width: 40,)),
            actions: [
              TextButton(onPressed: (){
                page.animateToPage(2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
              }, child: const Text(
              "About",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
              Padding(
                padding: const EdgeInsets.only(top: 4, right: 10),
                child: GestureDetector(
                    onTap: () {
                      page.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: ProfileCard(
                      pageController: page,
                      name: name ?? "",
                    )),
              ),
            
            ],
          ),
        ),
        body: PageView(
                controller: page,
                physics: const  NeverScrollableScrollPhysics(),
                children: [
                  Home(
                    controller: page,
                    sideMenuController: sideMenu,
                  ),
                  SecondPage(pageController: page,),
                  const AboutPage(),
                ],
              ),
          
        ),
      
    );
  }
}
