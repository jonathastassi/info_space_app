import 'package:info_space_app/app/data/datasources/i_people_in_space_remote_datasource.dart';
import 'package:info_space_app/app/data/models/people_in_space_model.dart';
import 'package:info_space_app/app/external/http/i_http_client.dart';
import 'package:info_space_app/core/errors/expections.dart';

class PeopleInSpaceRemoteDatasource implements IPeopleInSpaceRemoteDatasource {
  final IHttpClient httpClient;

  PeopleInSpaceRemoteDatasource({required this.httpClient});

  @override
  Future<List<PeopleInSpaceModel>> getPeoplesInSpace() async {
    try {
      final response =
          await httpClient.get('http://api.open-notify.org/astros.json');

      final result = response.data;

      if (result['message'] == 'success') {
        final listPeoples = result['people'] as List;

        return listPeoples
            .map((peoples) => PeopleInSpaceModel.fromJson(peoples))
            .toList();
      }
      throw ServerException();
    } catch (_) {
      throw ServerException();
    }
  }
}
