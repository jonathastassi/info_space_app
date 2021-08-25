import 'package:dartz/dartz.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/domain/repositories/i_people_in_space_repository.dart';
import 'package:info_space_app/core/errors/failure.dart';
import 'package:info_space_app/core/usecases/usecase.dart';

class GetPeoplesInSpaceUsecase
    extends UseCase<List<PeopleInSpaceEntity>, NoParams> {
  final IPeoplesInSpaceRepository peoplesInSpaceRepository;

  GetPeoplesInSpaceUsecase({required this.peoplesInSpaceRepository});

  @override
  Future<Either<Failure, List<PeopleInSpaceEntity>>> call(NoParams params) {
    return peoplesInSpaceRepository.getPeoplesInSpace();
  }
}
