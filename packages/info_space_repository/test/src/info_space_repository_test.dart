import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_repository/info_space_repository.dart';
import 'package:open_notify_api/open_notify_api.dart';
import 'package:mocktail/mocktail.dart';

class MockOpenNotifyApiClient extends Mock implements OpenNotifyApiClient {}

void main() {
  group('InfoSpaceRepository', () {
    late OpenNotifyApiClient apiClient;
    late InfoSpaceRepository infoSpaceRepository;

    setUp(() {
      apiClient = MockOpenNotifyApiClient();
      infoSpaceRepository = InfoSpaceRepository(
        apiClient: apiClient,
      );
    });

    group('constructor', () {
      test('does not require an apiClient', () {
        expect(InfoSpaceRepository(), isNotNull);
      });
    });

    group('getIssLocation', () {
      test('makes correct api request', () async {
        when(() => apiClient.getIssLocation()).thenAnswer(
          (_) async => IssLocationMap(
            timestamp: '1',
            position: LatLng(
              -21.3306,
              100.8100,
            ),
          ),
        );

        await infoSpaceRepository.getIssLocation();

        verify(() => apiClient.getIssLocation()).called(1);
      });
    });

    group('getPeoplesInSpace', () {
      test('makes correct api request', () async {
        when(() => apiClient.getPeoplesInSpace()).thenAnswer(
          (_) async => List.generate(
              3, (_) => PeopleInSpace(name: 'someName', craft: 'someCraft')),
        );

        await infoSpaceRepository.getPeoplesInSpace();

        verify(() => apiClient.getPeoplesInSpace()).called(1);
      });
    });
  });
}
