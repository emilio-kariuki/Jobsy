import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Ui/Authentication/auth.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

import '../../../Repositories/Auth.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  List data = [
    {
      "name": "Emilio Kariuki",
      "role": "Software Developer",
      "image": "lib/Assets/pencil.jpg",
      "description":
          "I am a software developer with a passion for building scalable and maintainable software. I am a team player and I am always willing to learn new things. I am currently pursuing a degree in Comput"
    },
    {
      "name": "Joseph Ndungu",
      "role": "Product Manager",
      "image": "lib/Assets/marker.jpg",
      "description":
          "I am a software developer with a passion for building scalable and maintainable software. I am a team player and I am always willing to learn new things. I am currently pursuing a degree in Comput"
    },
    {
      "name": "Edwin Mwangi",
      "role": "Backend Developer",
      "image": "lib/Assets/manyColors.jpg",
      "description":
          "I am a software developer with a passion for building scalable and maintainable software. I am a team player and I am always willing to learn new things. I am currently pursuing a degree in Comput"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 1,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('lib/Assets/laptop.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("Jobs Management System",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("\"This is where jobs unfold\"",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                height: height * 0.6,
                width: width,
                decoration: const BoxDecoration(
                  color: bgColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "The Team",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: height * 0.4,
                      width: width,
                      child: Center(
                        child: ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 60, right: 60),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  height: height * 0.4,
                                  width: width * 0.22,
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            AssetImage(data[index]["image"]),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data[index]['name'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data[index]['role'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data[index]['description'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: height * 0.5,
                  width: width,
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("About Us",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                          "Welcome to our freelancing website, where we provide a platform for skilled professionals to showcase their talents and connect with businesses across the globe. Our team is dedicated to providing a seamless experience for both freelancers and clients, with a focus on transparency, efficiency, and quality. Whether you are a freelancer looking to expand your client base or a business in need of top-notch talent, we have the tools and resources to help you succeed. Our mission is to empower freelancers to take control of their careers and build meaningful relationships with clients, while also providing businesses with the flexibility and expertise they need to thrive. Join our community today and let's make great things happen together!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold)),
                    ],
                  )),
            ],
          ),
        ));
  }
}
