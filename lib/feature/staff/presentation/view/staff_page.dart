import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/base/presentation/widgets/common.dart';
import 'package:dut_packing_system/feature/staff/presentation/controller/staff_controller.dart';
import 'package:dut_packing_system/feature/staff/presentation/view/check_qr_code/check_qr_code.dart';
import 'package:dut_packing_system/feature/staff/presentation/view/check_qr_code/check_qr_code_out.dart';
import 'package:dut_packing_system/feature/staff/presentation/view/scan_qr_code/scan_qr_code.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';

class StaffPage extends BaseWidget<StaffController> {
  StaffPage({Key? key}) : super(key: key);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3, 0.9],
      colors: [ColorName.whiteFff, ColorName.primaryColor],
    ),
    borderRadius: BorderRadius.circular(82),
  );

  @override
  Widget onBuild(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(
        () => Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: ColorName.whiteFff,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Assets.images.profileBanner.image(width: widthScreen),
                    const SizedBox(height: 55),
                    Center(
                      child: Text(
                        'Parking System',
                        style: AppTextStyle.w800s33(ColorName.primaryColor, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Uy ti??n ta??o n??n ch????t l??????ng - M????t xe ??????n g????p ????i',
                        style: AppTextStyle.w600s15(ColorName.black000, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 45),
                    Center(
                      child: Text(
                        "H?????ng d???n d??nh cho nh??n vi??n gi??? xe:",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.w600s13(ColorName.black000, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "- Khi c?? xe ??i v??o th???c hi???n qu??t m?? (??i v??o) v?? ki???m tra th??ng tin ph????ng ti???n so v???i th??ng tin x??c th???c t??? k???t qu??? m?? ???? qu??t.",
                        textAlign: TextAlign.left,
                        style: AppTextStyle.w500s13(ColorName.primaryColor, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "- Khi c?? xe ??i ra th???c hi???n qu??t m?? (??i ra) v?? ki???m tra th??ng tin ph????ng ti???n so v???i th??ng tin x??c th???c t??? k???t qu??? m?? ???? qu??t.",
                        textAlign: TextAlign.left,
                        style: AppTextStyle.w500s13(ColorName.primaryColor, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "- N???u m??y ???nh kh??ng ???????c hi???n th??? vui l??ng c???p quy???n truy c???p m??y ???nh c???a ???ng d???ng trong c??i ?????t.",
                        textAlign: TextAlign.left,
                        style: AppTextStyle.w500s13(ColorName.primaryColor, letterSpacing: 0.38),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: CommonButton(
                              onPressed: () => controller.startScan(false),
                              fillColor: ColorName.whiteFaf,
                              borderWidth: 1,
                              borderColor: ColorName.primaryColor,
                              child: Text(
                                '??i ra',
                                style: AppTextStyle.w500s13(ColorName.primaryColor),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: CommonButton(
                              onPressed: () => controller.startScan(true),
                              borderWidth: 1,
                              borderColor: ColorName.primaryColor,
                              fillColor: ColorName.primaryColor,
                              child: Text(
                                '??i v??o',
                                style: AppTextStyle.w500s13(ColorName.whiteFff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: CommonButton(
                        onPressed: () => controller.logout(),
                        borderWidth: 1,
                        borderColor: ColorName.primaryColor,
                        fillColor: ColorName.primaryColor,
                        child: Text(
                          '????ng xu???t',
                          style: AppTextStyle.w500s13(ColorName.whiteFff),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 10,
              right: 20,
              child: Assets.images.launcherIcon.image(width: 100),
            ),
            if (controller.isScan.value) scanQRCode(),
            if (controller.isChecked.value && controller.isCheckIn.value) checkQRCode(context),
            if (controller.isChecked.value && !controller.isCheckIn.value) checkQRCodeOut(context),
            if (controller.confirmState.value)
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
      ),
    );
  }
}
