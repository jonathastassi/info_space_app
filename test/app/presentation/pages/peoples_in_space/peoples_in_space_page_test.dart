import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_controller.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_page.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_state.dart';
import 'package:mocktail/mocktail.dart';

class MockPeoplesInSpaceController extends Mock
    implements PeoplesInSpaceController {}

void main() {
  group('Presentation - pages - PeoplesInSpacePage', () {
    late PeoplesInSpaceController peoplesInSpaceControllerMock;

    final locator = GetIt.instance;

    setUp(() {
      peoplesInSpaceControllerMock = MockPeoplesInSpaceController();
      locator.registerLazySingleton<PeoplesInSpaceController>(
        () => peoplesInSpaceControllerMock,
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
    });
  });
}
