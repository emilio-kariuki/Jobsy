import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/Responsive.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  const ProfileCard({super.key, required this.name});

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
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(
                name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
