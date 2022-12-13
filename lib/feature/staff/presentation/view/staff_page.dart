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
                        'Uy tín tạo nên chất lượng - Mất xe đền gấp đôi',
                        style: AppTextStyle.w600s15(ColorName.black000, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 45),
                    Center(
                      child: Text(
                        "Hướng dẫn dành cho nhân viên giữ xe:",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.w600s13(ColorName.black000, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "- Khi có xe đi vào thực hiện quét mã (đi vào) và kiểm tra thông tin phương tiện so với thông tin xác thực từ kết quả mã đã quét.",
                        textAlign: TextAlign.left,
                        style: AppTextStyle.w500s13(ColorName.primaryColor, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "- Khi có xe đi ra thực hiện quét mã (đi ra) và kiểm tra thông tin phương tiện so với thông tin xác thực từ kết quả mã đã quét.",
                        textAlign: TextAlign.left,
                        style: AppTextStyle.w500s13(ColorName.primaryColor, letterSpacing: 0.38),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "- Nếu máy ảnh không được hiển thị vui lòng cấp quyền truy cập máy ảnh của ứng dụng trong cài đặt.",
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
                                'Đi ra',
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
                                'Đi vào',
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
                          'Đăng xuất',
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
