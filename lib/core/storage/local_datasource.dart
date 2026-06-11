abstract class LocalDataSource {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
  Future<void> saveBool(String key, {required bool value});
  Future<bool?> getBool(String key);
  Future<void> saveInt(String key, {required int value});
  Future<int?> getInt(String key);
  Future<void> remove(String key);
  Future<void> clearAll();
  Future<bool> containsKey(String key);
}
