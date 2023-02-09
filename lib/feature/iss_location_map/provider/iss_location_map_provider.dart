import 'package:flutter/material.dart';
import 'package:info_space_app/feature/iss_location_map/controller/iss_location_map_controller.dart';

class IssLocationMapProvider
    extends InheritedNotifier<IssLocationMapController> {
  IssLocationMapProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static IssLocationMapController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<IssLocationMapProvider>()!
        .notifier!;
  }
}
