import 'package:info_space_app/app/data/datasources/i_iss_location_map_remote_datasource.dart';
import 'package:info_space_app/app/domain/entities/iss_location_map_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:info_space_app/app/domain/repositories/i_iss_location_map_repository.dart';
import 'package:info_space_app/core/errors/expections.dart';
import 'package:info_space_app/core/errors/failures.dart';
import 'package:info_space_app/core/network_status/i_network_status.dart';

class IssLocationMapRepository implements IIssLocationMapRepository {
  final IIssLocationMapRemoteDatasource issLocationMapRemoteDatasource;
  final INetworkStatus networkStatus;

  IssLocationMapRepository({
    required this.issLocationMapRemoteDatasource,
    required this.networkStatus,
  });

  @override
  Future<Either<Failure, IssLocationMapEntity>> getIssLocation() async {
    try {
      if (await networkStatus.isConnected) {
        final issLocationMapResult =
            await issLocationMapRemoteDatasource.getIssLocation();

        return Right(issLocationMapResult);
      }

      return Left(NoConnectionFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
