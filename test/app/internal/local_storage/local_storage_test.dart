import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:info_space_app/app/internal/local_storage/i_local_storage.dart';
import 'package:info_space_app/app/internal/local_storage/local_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  group('Internal - internal - LocalSorage', () {
    late GetStorage sharedPreferences;
    late ILocalStorage localStorage;

    setUp(() {
      sharedPreferences = MockGetStorage();
      localStorage = LocalStorage(sharedPreferences: sharedPreferences);
    });

    test('Should save value in shared prefs', () async {
      when(() => sharedPreferences.write(any(), any()))
          .thenAnswer((_) async => true);
      final result = await localStorage.setString('some_key', 'some_value');

      expect(result, isTrue);
    });

    test('Should return value stored in shared prefs', () {
      when(() => sharedPreferences.read(any())).thenReturn('some_value');

      final result = localStorage.getString('some_key');

      expect(result, 'some_value');
    });
  });
}
