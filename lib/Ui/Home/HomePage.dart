import 'package:flutter/material.dart';
import 'package:jobsy_flutter/Ui/Home/Pages/FirstPage.dart';
import 'package:jobsy_flutter/Ui/Home/Pages/SecondPage.dart';
import 'package:jobsy_flutter/Ui/Home/Pages/ThirdPage.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.white54,
        //     elevation: 0,
        //     leading: Row(
        //       children: [
        //         IconButton(
        //           icon: const Icon(Icons.menu),
        //           onPressed: () {},
        //         ),
        //       ],
        //     )),
        body: Row(
          children: [
            
            NavigationRail(
              leading:Image.asset(
                                  "lib/Assets/jobsy.jpeg",
                                  height: 50,
                                  width: 50,
                                ),
              backgroundColor: bgColor,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home,color: Colors.white,),
                  selectedIcon: Icon(Icons.home),
                  label: Text('First'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border,color: Colors.white,),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Second'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border,color: Colors.white,),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Third'),
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            
            const SizedBox(width: 3,),
        
            // This is the main content.
            _selectedIndex == 0  ? const Expanded(
              child: FirstPage()
            ) : _selectedIndex == 1 ? const Expanded(
              child: SecondPage()
            ) : const Expanded(
              child: ThirdPage()
            ),
          ],
        ));
  }
}
