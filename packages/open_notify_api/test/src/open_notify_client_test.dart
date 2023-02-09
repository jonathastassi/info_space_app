import 'package:flutter_test/flutter_test.dart';
import 'package:open_notify_api/open_notify_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_notify_api/src/models/lat_lng.dart';

class MockResponse extends Mock implements http.Response {}

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenNotifyApiClient', () {
    late http.Client httpClient;
    late OpenNotifyApiClient openNotifyApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      openNotifyApiClient = OpenNotifyApiClient(
        httpClient: httpClient,
      );
    });

    group('constructor', () {
      test('does not require a httpClient', () {
        expect(OpenNotifyApiClient(), isNotNull);
      });
    });

    group('getIssLocation', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await openNotifyApiClient.getIssLocation();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.http(
              'api.open-notify.org',
              '/iss-now.json',
            ),
          ),
        ).called(1);
      });

      test('throws IssLocationMapRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => openNotifyApiClient.getIssLocation(),
          throwsA(isA<IssLocationMapRequestFailure>()),
        );
      });

      test('throws IssLocationMapRequestFailure when messages is not success',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"message": "error"}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          openNotifyApiClient.getIssLocation(),
          throwsA(isA<IssLocationMapNotSuccessFailure>()),
        );
      });

      test('returns iss location on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          r'''
{
	"timestamp": 1675948454,
	"iss_position": {
		"latitude": "-21.3306",
		"longitude": "100.8100"
	},
	"message": "success"
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await openNotifyApiClient.getIssLocation();
        expect(
            actual,
            isA<IssLocationMap>()
                .having((i) => i.timestamp, 'timestamp', '1675948454')
                .having((i) => i.position.latitude, 'latitude', -21.3306)
                .having((i) => i.position.longitude, 'longitude', 100.8100));
      });
    });

    group('getPeoplesInSpace', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await openNotifyApiClient.getPeoplesInSpace();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.http(
              'api.open-notify.org',
              '/astros.json',
            ),
          ),
        ).called(1);
      });

      test('throws PeoplesInSpaceRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => openNotifyApiClient.getPeoplesInSpace(),
          throwsA(isA<PeoplesInSpaceRequestFailure>()),
        );
      });

      test('throws PeoplesInSpaceRequestFailure when messages is not success',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"message": "error"}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          openNotifyApiClient.getPeoplesInSpace(),
          throwsA(isA<PeoplesInSpaceNotSuccessFailure>()),
        );
      });

      test('returns list of peoples is space on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          r'''
{
	"message": "success",
	"people": [
		{
			"name": "Sergey Prokopyev",
			"craft": "ISS"
		},
		{
			"name": "Dmitry Petelin",
			"craft": "ISS"
		},
		{
			"name": "Frank Rubio",
			"craft": "ISS"
		},
		{
			"name": "Nicole Mann",
			"craft": "ISS"
		},
		{
			"name": "Josh Cassada",
			"craft": "ISS"
		},
		{
			"name": "Koichi Wakata",
			"craft": "ISS"
		},
		{
			"name": "Anna Kikina",
			"craft": "ISS"
		},
		{
			"name": "Fei Junlong",
			"craft": "Shenzhou 15"
		},
		{
			"name": "Deng Qingming",
			"craft": "Shenzhou 15"
		},
		{
			"name": "Zhang Lu",
			"craft": "Shenzhou 15"
		}
	],
	"number": 10
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await openNotifyApiClient.getPeoplesInSpace();
        expect(
            actual.first,
            isA<PeopleInSpace>()
                .having((i) => i.name, 'name', 'Sergey Prokopyev')
                .having((i) => i.craft, 'craft', 'ISS'));
      });
    });
  });
}
