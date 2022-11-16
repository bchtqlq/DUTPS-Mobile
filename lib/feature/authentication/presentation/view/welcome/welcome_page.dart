import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../base/presentation/widgets/common.dart';
import '../../../../../utils/config/app_text_style.dart';
import '../../../../../utils/gen/assets.gen.dart';
import '../../../../../utils/gen/colors.gen.dart';
import '../../controller/welcome/welcome_controller.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteFff,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Assets.images.launcherIcon.image(scale: 2),
              ),
              Text(
                'Parking System',
                style: AppTextStyle.w800s33(ColorName.primaryColor, letterSpacing: 0.38),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Uy tín tạo nên chất lượng - Mất xe đền gấp đôi',
                style: AppTextStyle.w600s15(ColorName.black000, letterSpacing: 0.38),
              ),
              const SizedBox(
                height: 192,
              ),
              CommonButton(
                height: 44,
                onPressed: controller.toLoginPage,
                fillColor: ColorName.primaryColor,
                child: Text(
                  'Đăng nhập',
                  style: AppTextStyle.w400s16(ColorName.whiteFff),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              CommonButton(
                height: 44,
                onPressed: controller.toRegisterCustomer,
                fillColor: Colors.transparent,
                borderColor: ColorName.primaryColor,
                child: Text('Đăng ký', style: AppTextStyle.w400s16(ColorName.primaryColor)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Text(
          'BCHTQLQ - 0.0.1 (1)',
          style: AppTextStyle.w400s10(ColorName.gray828),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
