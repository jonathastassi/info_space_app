import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:info_space_app/feature/iss_location_map/controller/iss_location_map_controller.dart';
import 'package:info_space_app/feature/iss_location_map/controller/iss_location_map_state.dart';
import 'package:info_space_app/shared/widgets/error_warning_widget.dart';
import 'package:info_space_app/shared/widgets/loading_widget.dart';
import 'package:info_space_app/shared/widgets/sliver_app_bar_custom.dart';
import 'package:info_space_repository/info_space_repository.dart';
import 'package:latlong2/latlong.dart' as ll;

class IssLocationMapTab extends StatelessWidget {
  const IssLocationMapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return IssLocationMapView(
      issLocationMapController: IssLocationMapController(
        infoSpaceRepository: InfoSpaceRepository(),
      ),
    );
  }
}

class IssLocationMapView extends StatefulWidget {
  const IssLocationMapView({
    super.key,
    required IssLocationMapController issLocationMapController,
  }) : _issLocationMapController = issLocationMapController;

  final IssLocationMapController _issLocationMapController;

  @override
  State<IssLocationMapView> createState() => _IssLocationMapViewState();
}

class _IssLocationMapViewState extends State<IssLocationMapView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget._issLocationMapController.initPage(),
    );

    super.initState();
  }

  @override
  void dispose() {
    widget._issLocationMapController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        widget._issLocationMapController.startTimerGetIssLocation();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        widget._issLocationMapController.closeTimerGetIssLocation();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final issLocationMapController = widget._issLocationMapController;

    return ValueListenableBuilder<IssLocationMapState>(
      builder: (_, state, header) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            header ?? const SizedBox.shrink(),
            if (state is LoadingIssLocationMapState)
              const SliverFillRemaining(
                child: LoadingWidget(),
              )
            else if (state is FailureIssLocationMapState)
              const SliverFillRemaining(
                child: LoadingWidget(),
              )
            else
              SliverFillRemaining(
                child: Stack(
                  children: [
                    if (state is FailureIssLocationMapState)
                      SliverFillRemaining(
                        child: ErrorWarningWidget(
                          onRetry: widget._issLocationMapController.initPage,
                        ),
                      )
                    else
                      FlutterMap(
                        mapController: issLocationMapController.mapController,
                        options: MapOptions(
                            initialCenter: const ll.LatLng(51.5, -0.09),
                            initialZoom: state is SuccessIssLocationMapState
                                ? (state).zoom
                                : 2.0,
                            maxZoom: 10,
                            minZoom: 1),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.info_space_app',
                          ),
                          if (state is SuccessIssLocationMapState &&
                              state.hasMarkerHistory) ...[
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: state.markerHistory
                                      .map((data) => ll.LatLng(
                                          data.latitude, data.longitude))
                                      .toList(),
                                  color: Theme.of(context).primaryColor,
                                  strokeWidth: 4,
                                ),
                              ],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point: ll.LatLng(
                                    state.getLastMarker.latitude,
                                    state.getLastMarker.longitude,
                                  ),
                                  child: Image.asset(
                                      'assets/images/satellite_icon.png'),
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    if (state is SuccessIssLocationMapState)
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Column(
                          children: [
                            FloatingActionButton(
                              heroTag: 'zoom_in',
                              onPressed: state.canAddZoom
                                  ? () => widget._issLocationMapController
                                      .setZoom(state.zoom + 1)
                                  : null,
                              enableFeedback: state.canAddZoom,
                              child: const Icon(Icons.zoom_in),
                            ),
                            const SizedBox(height: 10),
                            FloatingActionButton(
                              heroTag: 'zoom_out',
                              onPressed: state.canMinusZoom
                                  ? () => widget._issLocationMapController
                                      .setZoom(state.zoom - 1)
                                  : null,
                              enableFeedback: state.canMinusZoom,
                              child: const Icon(Icons.zoom_out),
                            ),
                            const SizedBox(height: 2),
                            Chip(
                              label: Text('${state.zoom}x'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
          ],
        );
      },
      valueListenable: issLocationMapController,
      child: SliverAppBarCustom(
        context,
        titlePage: 'info SPACE',
        titleTab: 'ISS Current Location',
        descriptionTab:
            'The International Space Station is moving at close to 28,000 km/h so its location changes really fast!',
      ),
    );
  }
}
