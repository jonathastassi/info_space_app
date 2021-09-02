import 'package:flutter/material.dart';
import 'package:info_space_app/core/dependency_injection/dependency_injection_config.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/routes/routes_config.dart';

String _getError(Failure error) {
  if (error is CacheFailure) {
    return 'Error reading offline data.';
  }

  if (error is ServerFailure) {
    return 'Error reading API data.';
  }

  return 'an error occurred!.';
}

void clearSnackBars() {
  ScaffoldMessenger.of(locator.get<RoutesConfig>().navigatorKey.currentContext!)
      .clearSnackBars();
}

void showErrorSnackbar({
  required String title,
  Failure? error,
}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.redAccent,
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          if (error != null)
            Text(
              _getError(error),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    ),
  );

  ScaffoldMessenger.of(locator.get<RoutesConfig>().navigatorKey.currentContext!)
      .showSnackBar(snackBar);
}
