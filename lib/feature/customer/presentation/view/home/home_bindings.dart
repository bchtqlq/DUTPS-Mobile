import 'package:get/get.dart';
import '../../controller/home/home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(Get.find()));
  }
}
