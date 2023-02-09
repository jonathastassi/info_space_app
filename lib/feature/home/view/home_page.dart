import 'package:flutter/material.dart';
import 'package:info_space_app/feature/home/controller/home_controller.dart';
import 'package:info_space_app/feature/home/controller/home_state.dart';
import 'package:info_space_app/feature/home/provider/home_provider.dart';
import 'package:info_space_app/feature/iss_location_map/view/iss_location_map_tab.dart';
import 'package:info_space_app/feature/peoples_in_space/view/peoples_in_space_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeProvider(
      notifier: HomeController(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = HomeProvider.of(context);

    return Scaffold(
      body: ValueListenableBuilder<HomeState>(
        valueListenable: homeController,
        builder: (_, state, __) {
          return [
            PeoplesInSpaceTab(),
            IssLocationMapTab(),
          ][state.index];
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<HomeState>(
        valueListenable: homeController,
        builder: (_, state, __) {
          return NavigationBar(
            animationDuration: const Duration(milliseconds: 800),
            onDestinationSelected: homeController.changeTab,
            selectedIndex: state.index,
            destinations: const <Widget>[
              NavigationDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: 'Peoples in Space',
              ),
              NavigationDestination(
                icon: Icon(Icons.radar_outlined),
                selectedIcon: Icon(Icons.radar),
                label: 'See ISS location',
              ),
            ],
          );
        },
      ),
    );
  }
}
