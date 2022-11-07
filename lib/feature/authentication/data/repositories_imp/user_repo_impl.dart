import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../domain/repositoties/user_repo.dart';
import '../models/list_user_model.dart';
import '../providers/remote/user_api.dart';

class UserRepoImpl implements UserRepo {
  final userAPI = Get.find<UserAPI>();
  @override
  Future<ListUserModel> getUserData() async {
    final listUser = await userAPI.getUserData();
    return listUser;
  }
}
