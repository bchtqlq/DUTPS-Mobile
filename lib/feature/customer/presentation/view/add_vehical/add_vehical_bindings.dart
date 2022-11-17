import 'package:dut_packing_system/feature/customer/domain/usecases/add_vehical_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/delete_vehical_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/update_vehical_usecase.dart';
import 'package:dut_packing_system/feature/customer/presentation/controller/add_vehical/add_vehical_controller.dart';
import 'package:get/get.dart';

class AddVehicalBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddVehicalUsecase(Get.find()));
    Get.lazyPut(() => GetCustomerInfoUsecase(Get.find()));
    Get.lazyPut(() => UpdateVehicalUsecase(Get.find()));
    Get.lazyPut(() => DeleteVehicalUsecase(Get.find()));
    Get.put(AddVehicalController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
  }
}
