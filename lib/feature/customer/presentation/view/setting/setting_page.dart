import 'package:dut_packing_system/base/presentation/base_app_bar.dart';
import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/base/presentation/widgets/common.dart';
import 'package:dut_packing_system/utils/config/app_navigation.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/extension/route_type.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import '../../controller/setting/setting_controller.dart';

class SettingPage extends BaseWidget<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: const Text('Cài đặt'),
      ),
      body: Obx(
        () => Stack(
          children: [
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Lịch sử",
                      style: AppTextStyle.w600s15(ColorName.black000),
                    ),
                  ),
                  settingItem(
                    topBorder: true,
                    title: "Lịch sử ra/vào nhà xe",
                    leading: const Icon(
                      Icons.history_outlined,
                      color: ColorName.primaryColor,
                    ),
                    onPressed: controller.toHistory,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Tài khoản",
                      style: AppTextStyle.w600s15(ColorName.black000),
                    ),
                  ),
                  settingItem(
                    topBorder: true,
                    title: "Chỉnh sửa thông tin cá nhân",
                    leading: const Icon(
                      Icons.edit_note_outlined,
                      color: ColorName.primaryColor,
                    ),
                    onPressed: () {
                      N.toProfile(isLogged: true, type: RouteType.to);
                    },
                  ),
                  settingItem(
                    title: "Đổi mật khẩu",
                    leading: const Icon(
                      Icons.key_outlined,
                      color: ColorName.primaryColor,
                    ),
                    onPressed: () {
                      controller.displayTextInputDialog(context);
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Đăng xuất",
                      style: AppTextStyle.w600s15(ColorName.black000),
                    ),
                  ),
                  settingItem(
                    title: "Đăng xuất",
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: ColorName.primaryColor,
                    ),
                    topBorder: true,
                    onPressed: controller.logout,
                  ),
                ],
              ),
            ),
            if (controller.changePasswordState.value)
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

Widget settingItem({
  String? title,
  Widget? leading,
  required Function() onPressed,
  bool topBorder = false,
}) {
  return CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: const BorderSide(width: 0.5, color: ColorName.grayBdb),
          top: topBorder ? const BorderSide(width: 0.5, color: ColorName.grayBdb) : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          leading ?? const SizedBox.shrink(),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title ?? "",
              style: AppTextStyle.w400s15(ColorName.black000),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: ColorName.primaryColor,
          ),
          const SizedBox(width: 16),
        ],
      ),
    ),
  );
}
