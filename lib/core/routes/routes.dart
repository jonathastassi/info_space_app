import 'package:flutter/cupertino.dart';
import 'package:info_space_app/core/routes/i_routes.dart';
import 'package:info_space_app/core/routes/routes_config.dart';

class Routes implements IRoutes {
  final RoutesConfig config;

  Routes({required this.config});

  @override
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName,
  ) {
    return Navigator.pushReplacementNamed<T, TO>(
        config.navigatorKey.currentContext!, routeName);
  }

  @override
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(
        config.navigatorKey.currentContext!, routeName,
        arguments: arguments);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    Navigator.pop<T>(config.navigatorKey.currentContext!, result);
  }
}
