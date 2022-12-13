import 'package:dut_packing_system/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:get/get.dart';
import '../../controller/root/root_controller.dart';

class RootBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetCustomerInfoUsecase(Get.find()));
    Get.put(RootController(Get.find(), Get.find()));
  }
}
