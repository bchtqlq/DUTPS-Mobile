import 'package:get/get.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../controller/login/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUsecase(Get.find()));
    Get.put(LoginController(Get.find(), Get.find()));
  }
}
