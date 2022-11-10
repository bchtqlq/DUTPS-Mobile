

import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';

class StorageServiceImpl implements StorageService {
  final _sharedPreferences = SharedPreferences.getInstance();
  @override
  Future<void> setToken(String token) async {
    (await _sharedPreferences).setString(AppConfig.keyToken, token);
  }
}