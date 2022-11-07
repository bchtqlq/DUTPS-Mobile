import 'package:get/get.dart';

import '../../../controller/register_customer/confirm_register_customer/confirm_register_customer_controller.dart';

class ConfirmRegisterCustomerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ConfirmRegisterCustomerController());
  }
}
