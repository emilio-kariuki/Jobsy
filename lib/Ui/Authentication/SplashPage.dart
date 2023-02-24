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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appName,
                        style: GoogleFonts.roboto(
                          fontSize: 40,
                          color: Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sodales blandit tortor, eget hendrerit lacus imperdiet a.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white54,
                          // fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 200,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(25),
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
