import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:info_space_app/app/presentation/utils/show_snackbar.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/routes/routes_config.dart';
import 'package:mocktail/mocktail.dart';

class MockRoutesConfig extends Mock implements RoutesConfig {}

void main() {
  group('Presentation - utils - showErrorSnackbar', () {
    late RoutesConfig routesConfig;

    final locator = GetIt.instance;

    setUp(() {
      routesConfig = MockRoutesConfig();
      locator.registerLazySingleton<RoutesConfig>(
        () => routesConfig,
      );
      when(() => routesConfig.navigatorKey)
          .thenReturn(GlobalKey<NavigatorState>());
    });

    tearDown(() {
      locator.reset();
    });

    testWidgets('Should show error snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: routesConfig.navigatorKey,
          home: Scaffold(
            body: TextButton(
              child: Text('Show'),
              onPressed: () => showErrorSnackbar(
                  title: 'title snackbar', error: CacheFailure()),
            ),
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.widgetWithText(TextButton, 'Show'));

      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('title snackbar'), findsOneWidget);
      expect(find.text('Error reading offline data.'), findsOneWidget);
    });

    testWidgets('Should show error snackbar (Error reading API data.)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: routesConfig.navigatorKey,
          home: Scaffold(
            body: TextButton(
              child: Text('Show'),
              onPressed: () => showErrorSnackbar(
                  title: 'title snackbar', error: ServerFailure()),
            ),
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.widgetWithText(TextButton, 'Show'));

      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('title snackbar'), findsOneWidget);
      expect(find.text('Error reading API data.'), findsOneWidget);
    });

    testWidgets('clearSnackBars should close all snackbars',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: routesConfig.navigatorKey,
          home: Scaffold(
            body: Column(
              children: [
                TextButton(
                  child: Text('Show'),
                  onPressed: () => showErrorSnackbar(
                      title: 'title snackbar', error: CacheFailure()),
                ),
                TextButton(
                  child: Text('Clear'),
                  onPressed: () => clearSnackBars(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();

      await tester.tap(find.widgetWithText(TextButton, 'Show'));

      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(TextButton, 'Clear'));

      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsNothing);
    });
  });
}
