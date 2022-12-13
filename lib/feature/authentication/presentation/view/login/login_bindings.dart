import 'package:dut_packing_system/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../controller/login/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUsecase(Get.find()));
    Get.lazyPut(() => GetCustomerInfoUsecase(Get.find()));
    Get.put(LoginController(Get.find(), Get.find(), Get.find()));
  }
}
