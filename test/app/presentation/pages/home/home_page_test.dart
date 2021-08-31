import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:info_space_app/app/presentation/pages/home/home_controller.dart';
import 'package:info_space_app/app/presentation/pages/home/home_page.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_controller.dart';
import 'package:info_space_app/app/presentation/pages/iss_location_map/iss_location_map_page.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_controller.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_page.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_state.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeController extends Mock implements HomeController {}

class MockPeoplesInSpaceController extends Mock
    implements PeoplesInSpaceController {}

class MockIssLocationMapController extends Mock
    implements IssLocationMapController {}

void main() {
  group('Presentation - pages - HomePage', () {
    late HomeController homeControllerMock;
    late PeoplesInSpaceController peoplesInSpaceControllerMock;
    late IssLocationMapController issLocationMapControllerMock;

    final locator = GetIt.instance;

    setUp(() {
      homeControllerMock = MockHomeController();
      peoplesInSpaceControllerMock = MockPeoplesInSpaceController();
      issLocationMapControllerMock = MockIssLocationMapController();
      locator.registerLazySingleton<HomeController>(
        () => homeControllerMock,
      );
      locator.registerLazySingleton<PeoplesInSpaceController>(
        () => peoplesInSpaceControllerMock,
      );
      locator.registerLazySingleton<IssLocationMapController>(
        () => issLocationMapControllerMock,
      );

      when(() => homeControllerMock.tabIndex).thenReturn(ValueNotifier<int>(0));
      when(() => peoplesInSpaceControllerMock.getPeoplesInSpace())
          .thenAnswer((_) async => null);
      when(() => peoplesInSpaceControllerMock.state).thenReturn(
          ValueNotifier<PeoplesInSpaceState>(PeoplesInSpaceState()));
    });

    tearDown(() {
      locator.reset();
    });

    testWidgets('Should be created', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(PeoplesInSpacePage), findsOneWidget);
      expect(find.byType(IssLocationMapPage), findsOneWidget);

      expect(find.text('Peoples in Space'), findsOneWidget);
      expect(find.text('See ISS location'), findsOneWidget);
    });

    testWidgets(
        'Should change to ISS location page when See ISS location is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('See ISS location'));

      await tester.pump();

      verify(() => homeControllerMock.changeTabIndex(1)).called(1);
    });

    testWidgets(
        'Should change to Peoples in space page when Peoples in Space is pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.text('Peoples in Space'));

      await tester.pump();

      verify(() => homeControllerMock.changeTabIndex(0)).called(1);
    });
  });
}
