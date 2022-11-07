import '../../../../../base/presentation/base_controller.dart';
import '../../../../../utils/config/app_navigation.dart';

class WelcomeController extends BaseController {
  WelcomeController();

  void toRegisterCustomer() {
    N.toRegisterCustomer();
  }

  void toLoginPage() {
    N.toLoginPage();
  }
}
