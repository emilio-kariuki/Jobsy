import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Firebase/Authentication.dart';
import 'package:jobsy_flutter/Ui/Authentication/auth.dart';

import '../../../Repositories/Auth.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
            child: ElevatedButton(
          onPressed: () {
            Auth().signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: Text("Sign out"),
        )),
      ),
    );
  }
}
