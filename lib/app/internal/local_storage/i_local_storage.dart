abstract class ILocalStorage {
  String? getString(String key);
  Future<bool> setString(String key, String value);
}
