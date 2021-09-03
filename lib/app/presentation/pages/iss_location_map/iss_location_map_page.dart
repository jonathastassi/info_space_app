import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_controller.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_state.dart';
import 'package:info_space_app/app/presentation/widgets/header_page.dart';
import 'package:info_space_app/core/dependency_injection/dependency_injection_config.dart';
import 'package:latlong2/latlong.dart';

class IssLocationMapPage extends StatefulWidget {
  static String route = '/iss-location-map';

  const IssLocationMapPage({Key? key}) : super(key: key);

  @override
  _IssLocationMapPageState createState() => _IssLocationMapPageState();
}

class _IssLocationMapPageState extends State<IssLocationMapPage>
    with WidgetsBindingObserver {
  final IssLocationMapController issLocationMapController =
      locator<IssLocationMapController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    issLocationMapController.startTimerGetIssLocation();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    issLocationMapController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        issLocationMapController.startTimerGetIssLocation();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        issLocationMapController.closeTimerGetIssLocation();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderPage(
        context,
        title: 'ISS Current Location',
        description:
            'The International Space Station is moving at close to 28,000 km/h so its location changes really fast!',
      ),
      body: ValueListenableBuilder<IssLocationMapState>(
        builder: (_, index, __) {
          return FlutterMap(
            mapController: issLocationMapController.mapController,
            options: MapOptions(
              screenSize: Size.fromHeight(300),
              center: LatLng(51.5, -0.09),
              zoom: 3.0,
              maxZoom: 10,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              if (index.markerHistory.length > 0)
                PolylineLayerOptions(
                  polylines: [
                    Polyline(
                      points: index.markerHistory,
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 4,
                    ),
                  ],
                ),
              if (index.issLocationMapEntity != null)
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: index.issLocationMapEntity!.position,
                      builder: (ctx) => Container(
                        child: Image.asset('assets/images/satellite_icon.png'),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
        valueListenable: issLocationMapController.state,
      ),
    );
  }
}
