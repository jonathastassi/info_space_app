import 'package:flutter_test/flutter_test.dart';
import 'package:info_space_app/core/errors/failures.dart';

void main() {
  group('Core - errors - failures', () {
    test('Two Server Failures should be equal', () {
      ServerFailure serverFailure = ServerFailure();
      ServerFailure serverFailure2 = ServerFailure();

      expect(serverFailure, serverFailure2);
    });

    test('Two Cache Failures should be equal', () {
      CacheFailure cacheFailure = CacheFailure();
      CacheFailure cacheFailure2 = CacheFailure();

      expect(cacheFailure, cacheFailure2);
    });
  });
}
