import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/core/usecases/usecase.dart';

void main() {
  group('Core - usecases - usecase', () {
    test('Check if Two NoParams object is equals', () {
      NoParams noParams = NoParams();
      NoParams noParams2 = NoParams();

      expect(noParams, noParams2);
    });
  });
}
