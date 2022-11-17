import 'package:dut_packing_system/feature/customer/domain/usecases/change_password_usecase.dart';
import 'package:get/get.dart';
import '../../controller/setting/setting_controller.dart';

class SettingBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordUsecase(Get.find()));
    Get.put(SettingController(Get.find(), Get.find()));
  }
}
