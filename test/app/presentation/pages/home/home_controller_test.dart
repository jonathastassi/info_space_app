import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Presentation - pages - HomeController', () {
    late HomeController homeController;

    setUp(() {
      homeController = HomeController();
    });

    test('ChangeTabIndex should change value of tabIndex', () {
      homeController.changeTabIndex(2);
      expect(homeController.tabIndex.value, 2);

      homeController.tabIndex.value = 4;
      expect(homeController.tabIndex.value, 4);
    });

    test('When homeController is disposed, should throws FlutterError', () {
      homeController.dispose();
      expect(
          () => homeController.changeTabIndex(2), throwsA(isA<FlutterError>()));
    });
  });
}
