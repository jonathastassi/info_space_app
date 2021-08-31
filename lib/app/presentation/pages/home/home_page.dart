import 'package:flutter/material.dart';
import 'package:info_space_app/app/presentation/pages/home/home_controller.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_page.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_page.dart';
import 'package:info_space_app/core/dependency_injection/dependency_injection_config.dart';

class HomePage extends StatefulWidget {
  static String route = '/home';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = locator<HomeController>();

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<int>(
          builder: (_, tabIndex, __) {
            return IndexedStack(
              index: tabIndex,
              children: [
                PeoplesInSpacePage(),
                IssLocationMapPage(),
              ],
            );
          },
          valueListenable: homeController.tabIndex,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        builder: (_, tabIndex, __) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: homeController.changeTabIndex,
            currentIndex: tabIndex,
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
          );
        },
        valueListenable: homeController.tabIndex,
      ),
    );
  }
}
