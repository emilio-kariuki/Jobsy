import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobsy_flutter/Ui/Authentication/auth.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';
import 'package:jobsy_flutter/Ui/Utilities/GlobalConstants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Row(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width/2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        appName,
                        style: GoogleFonts.roboto(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        "This is where Jobs unfold",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          // fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 400,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: Text(
                                  "Getting Started",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 17
                                      ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width /2,
              decoration: const BoxDecoration(
                  color: bgColor,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("lib/Assets/marker.jpg"))),
            )
          ],
        ));
  }
}
