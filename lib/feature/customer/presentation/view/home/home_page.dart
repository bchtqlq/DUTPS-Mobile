import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/base/presentation/widgets/common.dart';
import 'package:dut_packing_system/feature/customer/presentation/view/home/widgets/widget.dart';
import 'package:dut_packing_system/utils/config/app_navigation.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../controller/home/home_controller.dart';

class HomePage extends BaseWidget<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Xin chào,",
                                style: AppTextStyle.w600s17(ColorName.gray838),
                              ),
                              Text(
                                "${controller.customer.value.name}",
                                style: AppTextStyle.w700s25(ColorName.black000),
                              ),
                            ],
                          ),
                          const Spacer(),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              N.toSetting();
                            },
                            child: Assets.images.profileIcon.image(width: 45),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Danh sách phương tiện của bạn:",
                              style: AppTextStyle.w600s16(
                                ColorName.black000,
                              ),
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              N.toAddvehical();
                            },
                            child: Assets.images.edit.image(width: 30),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    if (controller.vehicals.isNotEmpty)
                      Obx(() {
                        return SizedBox(
                          height: 50,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(left: 16),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.vehicals.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: TabItem(
                                  isSelect: controller.selectIndex.value == index,
                                  title: controller.vehicals[index].licensePlate!,
                                  onPressed: () => controller.selectVehical(index),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    if (controller.vehicals.isEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.images.scooter.image(width: 100),
                                const SizedBox(height: 10),
                                Text(
                                  'Bạn chưa có bất kỳ phương tiện nào được đăng ký. Vui lòng đăng ký phương tiện để sử dụng',
                                  style: AppTextStyle.w400s16(
                                    ColorName.black000,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 25),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: Center(
                          child: QrImage(
                            data:
                                controller.customer.value.toJsonWithVehical(controller.vehicalQRCode.value).toString(),
                            version: QrVersions.auto,
                            size: 250.0,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: CommonButton(
                              onPressed: controller.checkOut,
                              borderWidth: 1,
                              borderColor: ColorName.primaryColor,
                              fillColor: ColorName.primaryColor,
                              child: Text(
                                'Đi ra',
                                style: AppTextStyle.w500s13(ColorName.whiteFff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (controller.viewCheckOut.value)
              Positioned.fill(
                child: GestureDetector(
                  onTap: controller.closeViewCheckOut,
                  child: Container(
                    color: ColorName.black000.withOpacity(0.6),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(50),
                          color: ColorName.whiteFff,
                          child: QrImage(
                            data: controller.checkOutString.value,
                            version: QrVersions.auto,
                            size: 250.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (controller.checkOutState.value)
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
