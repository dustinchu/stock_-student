abstract class PreferencesRepository {
  Future<void> saveAccount(String username);

  Future<String> getAccount();

  Future<void> removeAccount();
  Future<Map<String, dynamic>> getJson(String key,
      {Map<String, dynamic>? defaultValue});

  Future<bool> setJsonStr(String key, String value);
}
