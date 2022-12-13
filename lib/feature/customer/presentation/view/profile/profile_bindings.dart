import 'package:dut_packing_system/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_faculties_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/update_customer_usecase.dart';
import 'package:get/get.dart';
import '../../controller/profile/profile_controller.dart';

class ProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetFacultiesUsecase(Get.find()));
    Get.lazyPut(() => UpdateCustomerUsecase(Get.find()));
    Get.lazyPut(() => GetCustomerInfoUsecase(Get.find()));
    Get.put(ProfileController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
