import 'package:info_space_app/app/data/datasources/i_iss_location_map_remote_datasource.dart';
import 'package:info_space_app/app/data/models/iss_location_map_model.dart';
import 'package:info_space_app/app/data/models/position_model.dart';
import 'package:info_space_app/app/external/http/i_http_client.dart';
import 'package:info_space_app/core/errors/expections.dart';

class IssLocationMapRemoteDatasource
    implements IIssLocationMapRemoteDatasource {
  final IHttpClient httpClient;

  IssLocationMapRemoteDatasource({required this.httpClient});

  @override
  Future<IssLocationMapModel> getIssLocation() async {
    try {
      final response =
          await httpClient.get('http://api.open-notify.org/astros.json');

      final result = response.data;

      if (result['message'] == 'success') {
        return IssLocationMapModel(
          timestamp: result['timestamp'].toString(),
          position: PositionModel(
            latitude: result['iss_position']['latitude'],
            longitude: result['iss_position']['longitude'],
          ),
        );
      }
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}
