import 'package:dut_packing_system/base/presentation/widgets/common.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/root/root_controller.dart';

class RootPage extends GetView<RootController> {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteFff,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
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
                      onPressed: null,
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
                      onPressed: null,
                      fillColor: Colors.transparent,
                      borderColor: ColorName.primaryColor,
                      child: Text('Đăng ký', style: AppTextStyle.w400s16(ColorName.primaryColor)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            left: 10,
            bottom: 20,
            child: Container(
              width: double.infinity,
              child: Text(
                'BCHQT - 0.0.1 (1)',
                style: AppTextStyle.w400s10(ColorName.gray828),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: ColorName.black000.withOpacity(0.6),
              child: const LoadingWidget(
                color: ColorName.whiteFff,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
