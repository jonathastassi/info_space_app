import 'package:get_storage/get_storage.dart';
import 'package:info_space_app/app/internal/local_storage/i_local_storage.dart';

class LocalStorage implements ILocalStorage {
  final GetStorage sharedPreferences;

  LocalStorage({required this.sharedPreferences});

  @override
  String? getString(String key) {
    try {
      return sharedPreferences.read(key);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> setString(String key, String value) async {
    try {
      await sharedPreferences.write(key, value);
      return true;
    } catch (_) {
      return false;
    }
  }
}
