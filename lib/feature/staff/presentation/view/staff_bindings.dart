import 'package:dut_packing_system/feature/staff/presentation/controller/staff_controller.dart';
import 'package:get/get.dart';

class StaffBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(StaffController());
  }
}
