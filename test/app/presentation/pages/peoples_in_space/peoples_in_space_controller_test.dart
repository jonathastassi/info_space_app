import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/domain/usecases/get_peoples_in_space_usecase.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_controller.dart';
import 'package:info_space_app/app/presentation/pages/peoples_in_space/peoples_in_space_state.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/usecases/usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPeoplesInSpaceUsecase extends Mock
    implements GetPeoplesInSpaceUsecase {}

void main() {
  group('Presentation - pages - PeoplesInSpaceController', () {
    late GetPeoplesInSpaceUsecase getPeoplesInSpaceUsecaseMock;
    late PeoplesInSpaceController peoplesInSpaceController;

    setUp(() {
      getPeoplesInSpaceUsecaseMock = MockGetPeoplesInSpaceUsecase();
      peoplesInSpaceController = PeoplesInSpaceController(
          getPeoplesInSpaceUsecase: getPeoplesInSpaceUsecaseMock);
    });

    test('Fill list when usecase return success', () async {
      final list = [
        PeopleInSpaceEntity(name: 'some name', craft: 'some craft'),
        PeopleInSpaceEntity(name: 'some name 2', craft: 'some craft 2'),
        PeopleInSpaceEntity(name: 'some name 3', craft: 'some craft 3'),
      ];

      when(() => getPeoplesInSpaceUsecaseMock.call(NoParams())).thenAnswer(
          (_) async => Right<Failure, List<PeopleInSpaceEntity>>(list));

      await peoplesInSpaceController.getPeoplesInSpace();

      expect(peoplesInSpaceController.state.value.peopleInSpaceList.length,
          list.length);
    });

    test('Set failure when usecase return success', () async {
      when(() => getPeoplesInSpaceUsecaseMock.call(NoParams())).thenAnswer(
          (_) async =>
              Left<Failure, List<PeopleInSpaceEntity>>(ServerFailure()));

      await peoplesInSpaceController.getPeoplesInSpace();

      expect(peoplesInSpaceController.state.value.failure, ServerFailure());
    });

    test(
        'When PeoplesInSpaceController is disposed, should throws FlutterError when try use state',
        () {
      peoplesInSpaceController.dispose();
      expect(
          () => peoplesInSpaceController.state.value =
              PeoplesInSpaceState.loading(),
          throwsA(isA<FlutterError>()));
    });
  });
}
