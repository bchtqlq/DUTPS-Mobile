import 'package:dut_packing_system/feature/staff/domain/usecases/create_check_in_usecase.dart';
import 'package:dut_packing_system/feature/staff/domain/usecases/create_check_out_usecase.dart';
import 'package:dut_packing_system/feature/staff/presentation/controller/staff_controller.dart';
import 'package:get/get.dart';

class StaffBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCheckInUsecase(Get.find()));
    Get.lazyPut(() => CreateCheckOutUsecase(Get.find()));
    Get.put(StaffController(Get.find(), Get.find(), Get.find()));
  }
}
