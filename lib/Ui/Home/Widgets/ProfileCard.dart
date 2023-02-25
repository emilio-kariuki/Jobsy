import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Repositories/Auth.dart';
import 'package:jobsy_flutter/Ui/Authentication/LoginPage.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';

enum user { profile, logout }

class ProfileCard extends StatelessWidget {
  final String name;
  final PageController pageController;
  const ProfileCard(
      {super.key,
      required this.name,
      required this.pageController,
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("lib/Assets/bulb.jpg"),
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          PopupMenuButton<user>(
            offset: const Offset(15, 40),
            color: bgColor,
            onSelected: (value) {
              switch (value) {
                case user.profile:
                  
                  pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  break;
                case user.logout:
                  Auth().signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                  break;
              }
            },
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 20,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: user.profile,
                child: Text(
                  "Profile",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              const PopupMenuItem(
                value: user.logout,
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
