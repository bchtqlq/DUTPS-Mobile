import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_cupertino_app.dart';
import 'package:get/route_manager.dart';
import 'main.reflectable.dart';
import 'utils/config/app_binding.dart';
import 'utils/config/app_route.dart';

void main() async {
  _initApp();
  initializeReflectable();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(primaryColor: ColorName.whiteFff),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialBinding: AppBinding(),
      getPages: AppRoute.generateGetPages,
      initialRoute: AppRoute.root,
    );
  }
}

void _initApp() {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}
