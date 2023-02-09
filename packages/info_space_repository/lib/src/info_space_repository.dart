import 'package:open_notify_api/open_notify_api.dart';

class InfoSpaceRepository {
  InfoSpaceRepository({
    OpenNotifyApiClient? apiClient,
  }) : _apiClient = apiClient ?? OpenNotifyApiClient();

  final OpenNotifyApiClient _apiClient;

  Future<IssLocationMap> getIssLocation() => _apiClient.getIssLocation();

  Future<List<PeopleInSpace>> getPeoplesInSpace() =>
      _apiClient.getPeoplesInSpace();
}
