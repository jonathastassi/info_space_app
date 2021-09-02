import 'package:dartz/dartz.dart';
import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
import 'package:info_space_app/app/domain/repositories/i_iss_location_map_repository.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/usecases/usecase.dart';

class GetIssLocationMapUsecase
    implements UseCase<IssLocationMapEntity, NoParams> {
  final IIssLocationMapRepository issLocationMapRepository;

  GetIssLocationMapUsecase({
    required this.issLocationMapRepository,
  });

  @override
  Future<Either<Failure, IssLocationMapEntity>> call(NoParams params) {
    return issLocationMapRepository.getIssLocation();
  }
}
