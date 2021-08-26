import 'package:dartz/dartz.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/core/errors/failures.dart';

abstract class IPeoplesInSpaceRepository {
  Future<Either<Failure, List<PeopleInSpaceEntity>>> getPeoplesInSpace();
}