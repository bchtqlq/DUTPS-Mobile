import 'package:dut_packing_system/feature/customer/domain/usecases/get_history_usecase.dart';
import 'package:get/get.dart';
import '../../controller/history/history_controller.dart';

class HistoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetHistoryUsecase(Get.find()));
    Get.put(HistoryController(Get.find(), Get.find()));
  }
}
