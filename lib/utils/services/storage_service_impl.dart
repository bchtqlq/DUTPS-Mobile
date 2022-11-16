import 'package:dut_packing_system/utils/config/app_config.dart';
import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServiceImpl implements StorageService {
  final _sharedPreferences = SharedPreferences.getInstance();

  final _userInfoKey = "UserInfoKey";

  @override
  Future<void> setToken(String token) async {
    (await _sharedPreferences).setString(AppConfig.keyToken, token);
  }

  @override
  Future<String> getToken() async {
    return (await _sharedPreferences).getString(AppConfig.keyToken) ?? "";
  }

  @override
  Future<void> removeToken() async {
    (await _sharedPreferences).remove(AppConfig.keyToken);
  }

  @override
  Future<void> setCustomer(String shipper) async {
    (await _sharedPreferences).setString(_userInfoKey, shipper);
  }

  @override
  Future<String> getCustomer() async {
    return (await _sharedPreferences).getString(_userInfoKey) ?? "";
  }

  @override
  Future<void> removeCustomer() async {
    (await _sharedPreferences).remove(_userInfoKey);
  }
}
