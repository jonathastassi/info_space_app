import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_controller.dart';
import 'package:info_space_app/app/presentation/pages/splash/splash_page.dart';
import 'package:mocktail/mocktail.dart';

class MockSplashController extends Mock implements SplashController {}

void main() {
  group('Presentation - pages - SplashPage', () {
    late SplashController splashControllerMock;

    final locator = GetIt.instance;

    setUp(() {
      splashControllerMock = MockSplashController();
      locator.registerLazySingleton<SplashController>(
        () => splashControllerMock,
      );
    });

    tearDown(() {
      locator.reset();
    });

    testWidgets('Should be created by constructor',
        (WidgetTester tester) async {
      when(() => locator.get<SplashController>().goToHome())
          .thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: SplashPage(),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('info SPACE'), findsOneWidget);

      verify(() => splashControllerMock.goToHome()).called(1);
    });
  });
}
