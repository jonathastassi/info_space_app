import 'package:dartz/dartz.dart';
import 'package:info_space_app/app/data/datasources/i_people_in_space_local_datasource.dart';

import 'package:info_space_app/app/data/datasources/i_people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/domain/entities/people_in_space_entity.dart';
import 'package:info_space_app/app/domain/repositories/i_people_in_space_repository.dart';
import 'package:info_space_app/core/errors/expections.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/network_status/i_network_status.dart';

class PeopleInSpaceRepository implements IPeopleInSpaceRepository {
  IPeopleInSpaceRemoteDatasource peopleInSpaceRemoteDatasource;
  IPeopleInSpaceLocalDatasource peopleInSpaceLocalDatasource;
  INetworkStatus networkStatus;

  PeopleInSpaceRepository({
    required this.peopleInSpaceRemoteDatasource,
    required this.peopleInSpaceLocalDatasource,
    required this.networkStatus,
  });

  @override
  Future<Either<Failure, List<PeopleInSpaceEntity>>> getPeoplesInSpace() async {
    try {
      if (await networkStatus.isConnected) {
        final peoplesInSpaceResult =
            await peopleInSpaceRemoteDatasource.getPeoplesInSpace();
        await peopleInSpaceLocalDatasource
            .cacheLastPeoplesInSpace(peoplesInSpaceResult);

        return Right(peoplesInSpaceResult);
      }

      final lastpeoplesInSpaceResult =
          await peopleInSpaceLocalDatasource.getLastPeoplesInSpace();
      return Right(lastpeoplesInSpaceResult);
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
