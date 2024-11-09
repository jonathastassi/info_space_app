import 'package:flutter/material.dart';
import 'package:info_space_app/feature/home/controller/home_controller.dart';
import 'package:info_space_app/feature/home/controller/home_state.dart';
import 'package:info_space_app/feature/iss_location_map/view/iss_location_map_tab.dart';
import 'package:info_space_app/feature/peoples_in_space/view/peoples_in_space_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeView(
      homeController: HomeController(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required HomeController homeController,
  }) : _homeController = homeController;

  final HomeController _homeController;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void dispose() {
    widget._homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<HomeState>(
        valueListenable: widget._homeController,
        builder: (_, state, __) => IndexedStack(
          index: state.index,
          children: const [
            PeoplesInSpaceTab(),
            IssLocationMapTab(),
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<HomeState>(
        valueListenable: widget._homeController,
        builder: (_, state, __) {
          return NavigationBar(
            animationDuration: const Duration(milliseconds: 800),
            onDestinationSelected: widget._homeController.changeTab,
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
