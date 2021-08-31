import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/presentation/pages/home/home_page.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_controller.dart';
import 'package:info_space_app/core/routes/routes.dart';
import 'package:mocktail/mocktail.dart';

class MockRoutes extends Mock implements Routes {}

void main() {
  group('Presentation - pages - SplashController', () {
    late SplashController splashController;
    late Routes mockRoutes;

    setUp(() {
      mockRoutes = MockRoutes();
      splashController = SplashController(
        routes: mockRoutes,
      );
    });

    test('Should redirect to home when goToHome is called', () async {
      when(() => mockRoutes.pushReplacementNamed(HomePage.route))
          .thenAnswer((_) async => Container());
      await splashController.goToHome();

      verify(() => mockRoutes.pushReplacementNamed(HomePage.route)).called(1);
    });
  });
}
