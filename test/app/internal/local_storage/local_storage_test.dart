import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/app/internal/local_storage/i_local_storage.dart';
import 'package:info_space_app/app/internal/local_storage/local_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockGetStorage extends Mock implements SharedPreferences {}

void main() {
  group('Internal - internal - LocalSorage', () {
    late SharedPreferences sharedPreferences;
    late ILocalStorage localStorage;

    setUp(() {
      sharedPreferences = MockGetStorage();
      localStorage = LocalStorage(sharedPreferences: sharedPreferences);
    });

    test('Should save value in shared prefs', () async {
      when(() => sharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      final result = await localStorage.setString('some_key', 'some_value');

      expect(result, isTrue);
    });

    test('Should return value stored in shared prefs', () {
      when(() => sharedPreferences.getString(any())).thenReturn('some_value');

      final result = localStorage.getString('some_key');

      expect(result, 'some_value');
    });
  });
}
