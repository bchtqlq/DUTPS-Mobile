import '../extension/route_type.dart';
import 'app_route.dart';

class N {
  static void toDemoPage({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.demo);
  }

  static void toWelcomePage({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.welcome);
  }

  static void toLoginPage({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.login);
  }

  static void toForgotPasswordPage({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.forgotPassword);
  }

  static void toForgotPasswordOtpPage({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.forgotPasswordOtp);
  }

  static void toRegisterCustomer({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.registerCustomer);
  }

  static void toConfirmRegisterCustomer({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.confirmRegisterCustomer);
  }

  static void toChatHome({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.chatHome);
  }

  static void toStaffPage({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.staffPage);
  }

  static void toProfile({RouteType type = RouteType.offAll, bool isLogged = false}) {
    type.navigate(name: AppRoute.profile, arguments: isLogged);
  }

  static void toHome({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.home);
  }

  static void toAddvehical({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.addVehical);
  }

  static void toSetting({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.setting);
  }

   static void toHistory({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.history);
  }
}
