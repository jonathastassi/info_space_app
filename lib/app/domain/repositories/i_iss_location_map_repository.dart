import 'package:dartz/dartz.dart';
import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
import 'package:info_space_app/core/errors/failures.dart';

abstract class IIssLocationMapRepository {
  Future<Either<Failure, IssLocationMapEntity>> getIssLocation();
}
