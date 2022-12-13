import 'package:dut_packing_system/feature/customer/domain/usecases/get_check_in_usecase.dart';
import 'package:get/get.dart';
import '../../controller/home/home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetCheckInUsecase(Get.find()));
    Get.put(HomeController(Get.find(), Get.find()));
  }
}
