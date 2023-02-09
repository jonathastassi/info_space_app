import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_space_app/feature/iss_location_map/controller/iss_location_map_controller.dart';
import 'package:info_space_app/feature/iss_location_map/controller/iss_location_map_state.dart';
import 'package:info_space_app/feature/iss_location_map/provider/iss_location_map_provider.dart';
import 'package:info_space_app/shared/widgets/loading_widget.dart';
import 'package:info_space_app/shared/widgets/sliver_app_bar_custom.dart';
import 'package:info_space_repository/info_space_repository.dart';
import 'package:latlong2/latlong.dart' as ll;

class IssLocationMapTab extends StatelessWidget {
  const IssLocationMapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return IssLocationMapProvider(
      notifier: IssLocationMapController(
        infoSpaceRepository: InfoSpaceRepository(),
      ),
      child: const IssLocationMapView(),
    );
  }
}

class IssLocationMapView extends StatefulWidget {
  const IssLocationMapView({Key? key}) : super(key: key);

  @override
  _IssLocationMapViewState createState() => _IssLocationMapViewState();
}

class _IssLocationMapViewState extends State<IssLocationMapView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => IssLocationMapProvider.of(context).initPage());

    super.initState();
  }

  @override
  void dispose() {
    IssLocationMapProvider.of(context).dispose();
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);

  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       issLocationMapController.startTimerGetIssLocation();
  //       break;
  //     case AppLifecycleState.inactive:
  //     case AppLifecycleState.paused:
  //     case AppLifecycleState.detached:
  //       issLocationMapController.closeTimerGetIssLocation();
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final issLocationMapController = IssLocationMapProvider.of(context);

    return ValueListenableBuilder<IssLocationMapState>(
      builder: (_, state, __) {
        return CustomScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBarCustom(
              context,
              titlePage: 'info SPACE',
              titleTab: 'ISS Current Location',
              descriptionTab:
                  'The International Space Station is moving at close to 28,000 km/h so its location changes really fast!',
            ),
            if (state is LoadingIssLocationMapState)
              SliverFillRemaining(
                child: LoadingWidget(),
              )
            else if (state is FailureIssLocationMapState)
              SliverFillRemaining(
                child: LoadingWidget(),
              )
            else
              SliverFillRemaining(
                child: FlutterMap(
                  mapController: issLocationMapController.mapController,
                  options: MapOptions(
                    screenSize: Size.fromHeight(300),
                    center: ll.LatLng(51.5, -0.09),
                    zoom: 3.0,
                    maxZoom: 10,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.info_space_app',
                    ),
                    // if (state.markerHistory.length > 0)
                    //   PolylineLayer(
                    //     polylines: [
                    //       Polyline(
                    //         points: state.markerHistory,
                    //         color: Theme.of(context).primaryColor,
                    //         strokeWidth: 4,
                    //       ),
                    //     ],
                    //   ),
                    // if (state.issLocationMapEntity != null)
                    //   MarkerLayer(
                    //     markers: [
                    //       Marker(
                    //         width: 80.0,
                    //         height: 80.0,
                    //         point: state.issLocationMapEntity!.position,
                    //         builder: (ctx) => Container(
                    //           child: Image.asset(
                    //               'assets/images/satellite_icon.png'),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
          ],
        );
      },
      valueListenable: issLocationMapController,
    );
  }
}
