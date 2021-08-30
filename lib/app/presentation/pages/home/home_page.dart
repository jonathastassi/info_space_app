import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_space_app/app/presentation/pages/home/home_controller.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_page.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_page.dart';

class HomePage extends StatelessWidget {
  static String route = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                PeoplesInSpacePage(),
                IssLocationMapPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Peoples in Space',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.radar_outlined),
                label: 'See ISS location',
              ),
            ],
          ),
        );
      },
    );
  }
}
