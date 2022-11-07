import 'package:get/get.dart';

import '../../controller/register_customer/register_customer_controller.dart';

class RegisterCustomerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterCustomerController());
  }
}
