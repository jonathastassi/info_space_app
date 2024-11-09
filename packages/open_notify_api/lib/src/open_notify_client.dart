import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_notify_api/src/exceptions/exceptions.dart';
import 'package:open_notify_api/src/models/iss_location_map.dart';
import 'package:open_notify_api/src/models/people_in_space.dart';

class OpenNotifyApiClient {
  OpenNotifyApiClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'api.open-notify.org';

  final http.Client _httpClient;

  Future<IssLocationMap> getIssLocation() async {
    final request = Uri.http(
      _baseUrl,
      '/iss-now.json',
    );

    final response = await _httpClient.get(request).timeout(
          const Duration(
            seconds: 10,
          ),
        );

    if (response.statusCode != 200) {
      throw IssLocationMapRequestFailure();
    }

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    if (responseJson['message'] != 'success') {
      throw IssLocationMapNotSuccessFailure();
    }

    return IssLocationMap.fromJson(responseJson);
  }

  Future<List<PeopleInSpace>> getPeoplesInSpace() async {
    final request = Uri.http(
      _baseUrl,
      '/astros.json',
    );

    final response = await _httpClient.get(request).timeout(
          const Duration(
            seconds: 10,
          ),
        );
    ;

    if (response.statusCode != 200) {
      throw PeoplesInSpaceRequestFailure();
    }

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

    if (responseJson['message'] != 'success') {
      throw PeoplesInSpaceNotSuccessFailure();
    }

    return (responseJson['people'] as List)
        .map((peoples) => PeopleInSpace.fromJson(peoples))
        .toList();
  }
}
