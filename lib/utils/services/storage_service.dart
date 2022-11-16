abstract class StorageService {
  Future<void> setToken(String token);
  Future<String> getToken();
  Future<void> removeToken();
  Future<void> setCustomer(String user);
  Future<String> getCustomer();
  Future<void> removeCustomer();
}
