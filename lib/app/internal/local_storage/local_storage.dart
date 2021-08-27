import 'package:info_space_app/app/internal/local_storage/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements ILocalStorage {
  final SharedPreferences sharedPreferences;

  LocalStorage({required this.sharedPreferences});

  @override
  String? getString(String key) {
    try {
      return sharedPreferences.getString(key);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> setString(String key, String value) {
    try {
      return sharedPreferences.setString(key, value);
    } catch (e) {
      throw e;
    }
  }
}
