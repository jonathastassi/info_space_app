import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info_space_app/core/errors/failures.dart';

String _getError(Failure error) {
  if (error is CacheFailure) {
    return 'Error reading offline data.';
  }

  if (error is ServerFailure) {
    return 'Error reading API data.';
  }

  return 'an error occurred!.';
}

void showErrorSnackbar({
  required String title,
  Failure? error,
}) =>
    Get.snackbar(title, error != null ? _getError(error) : '',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white);
