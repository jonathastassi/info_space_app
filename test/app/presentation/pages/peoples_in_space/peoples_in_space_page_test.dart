import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_controller.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_page.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_state.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/routes/routes_config.dart';
import 'package:mocktail/mocktail.dart';

class MockPeoplesInSpaceController extends Mock
    implements PeoplesInSpaceController {}

class MockRoutesConfig extends Mock implements RoutesConfig {}

void main() {
  group('Presentation - pages - PeoplesInSpacePage', () {
    late PeoplesInSpaceController peoplesInSpaceControllerMock;
    late RoutesConfig routesConfig;

    final locator = GetIt.instance;

    setUp(() {
      peoplesInSpaceControllerMock = MockPeoplesInSpaceController();
      routesConfig = MockRoutesConfig();
      locator.registerLazySingleton<PeoplesInSpaceController>(
        () => peoplesInSpaceControllerMock,
      );
      locator.registerLazySingleton<RoutesConfig>(
        () => routesConfig,
      );
    });

    tearDown(() {
      locator.reset();
    });

    testWidgets('Should be created', (WidgetTester tester) async {
      final list = [
        PeopleInSpaceEntity(name: 'some name', craft: 'some craft'),
        PeopleInSpaceEntity(name: 'some name 2', craft: 'some craft 2'),
        PeopleInSpaceEntity(name: 'some name 3', craft: 'some craft 3'),
      ];

      when(() => peoplesInSpaceControllerMock.getPeoplesInSpace())
          .thenAnswer((_) async => null);
      when(() => peoplesInSpaceControllerMock.state).thenReturn(
          ValueNotifier<PeoplesInSpaceState>(
              PeoplesInSpaceState.showList(list)));

      await tester.pumpWidget(
        MaterialApp(
          home: PeoplesInSpacePage(),
        ),
      );

      expect(find.text('some name'), findsOneWidget);
      expect(find.text('some craft'), findsOneWidget);
    });

    testWidgets('When has an error, should show a snackbar',
        (WidgetTester tester) async {
      when(() => peoplesInSpaceControllerMock.getPeoplesInSpace())
          .thenAnswer((_) async => null);
      when(() => peoplesInSpaceControllerMock.state).thenReturn(
          ValueNotifier<PeoplesInSpaceState>(
              PeoplesInSpaceState.setFailure(CacheFailure())));
      when(() => routesConfig.navigatorKey)
          .thenReturn(GlobalKey<NavigatorState>());

      await tester.pumpWidget(
        MaterialApp(
          home: PeoplesInSpacePage(),
          navigatorKey: routesConfig.navigatorKey,
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
