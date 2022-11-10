import 'package:dut_packing_system/feature/authentication/domain/usecases/register_usecase.dart';
import 'package:get/get.dart';

import '../../controller/register_customer/register_customer_controller.dart';

class RegisterCustomerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterUsecase(Get.find()));
    Get.put(RegisterCustomerController(Get.find(), Get.find()));
  }
}
