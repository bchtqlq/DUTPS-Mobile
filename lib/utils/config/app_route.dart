import 'package:dut_packing_system/feature/staff/presentation/view/staff_bindings.dart';
import 'package:dut_packing_system/feature/staff/presentation/view/staff_page.dart';
import 'package:get/route_manager.dart';

import '../../../feature/authentication/presentation/view/demo/demo_bindings.dart';
import '../../../feature/authentication/presentation/view/demo/demo_page.dart';
import '../../feature/authentication/presentation/view/forgot_password/forgot_password_bindings.dart';
import '../../feature/authentication/presentation/view/forgot_password/forgot_password_otp_page.dart';
import '../../feature/authentication/presentation/view/forgot_password/forgot_password_page.dart';
import '../../feature/authentication/presentation/view/login/login_bindings.dart';
import '../../feature/authentication/presentation/view/login/login_page.dart';
import '../../feature/authentication/presentation/view/register_customer/register_customer_bindings.dart';
import '../../feature/authentication/presentation/view/register_customer/register_customer_page.dart';
import '../../feature/authentication/presentation/view/root/root_bindings.dart';
import '../../feature/authentication/presentation/view/root/root_page.dart';
import '../../feature/authentication/presentation/view/welcome/welcome_bindings.dart';
import '../../feature/authentication/presentation/view/welcome/welcome_page.dart';

class AppRoute {
  static String root = '/';
  static String demo = '/demo';
  static String welcome = '/welcome';
  static String login = '/login';
  static String forgotPassword = '/forgotPassword';
  static String forgotPasswordOtp = '/forgotPasswordOtp';
  static String registerCustomer = '/register_customer';
  static String confirmRegisterCustomer = '/confirmRegisterCustomer';
  static String chatHome = '/chatHome';
  static String staffPage = '/staffPage';

  static List<GetPage> generateGetPages = [
    GetPage(
      name: root,
      page: RootPage.new,
      binding: RootBindings(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: demo,
      page: DemoPage.new,
      binding: DemoBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: welcome,
      page: WelcomePage.new,
      binding: WelcomeBindings(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: LoginPage.new,
      binding: LoginBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: forgotPassword,
      page: ForgotPasswordPage.new,
      binding: ForgotPasswordBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: forgotPasswordOtp,
      page: ForgotPasswordOtpPage.new,
      binding: ForgotPasswordBindings(),
    ),
    GetPage(
      name: registerCustomer,
      page: RegisterCustomerPage.new,
      binding: RegisterCustomerBindings(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: staffPage,
      page: StaffPage.new,
      binding: StaffBindings(),
      transition: Transition.cupertino,
    ),
  ];
}
