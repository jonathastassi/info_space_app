import 'package:flutter/material.dart';
import 'package:info_space_app/feature/peoples_in_space/controller/peoples_in_space_controller.dart';

class PeoplesInSpaceProvider
    extends InheritedNotifier<PeoplesInSpaceController> {
  PeoplesInSpaceProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static PeoplesInSpaceController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PeoplesInSpaceProvider>()!
        .notifier!;
  }
}
