import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/base/presentation/widgets/common.dart';
import 'package:dut_packing_system/feature/staff/presentation/view/staff_page.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';

extension CheckQRCode on StaffPage {
  Widget checkQRCode(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Positioned.fill(
      child: Container(
        color: ColorName.backgroundColor,
        child: Stack(
          children: [
            Assets.images.profileBanner.image(width: widthScreen),
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 10,
              right: 20,
              child: Text(
                controller.isCheckIn.value ? "Đi vào" : "Đi ra",
                style: AppTextStyle.w700s17(ColorName.whiteFff),
              ),
            ),
            Positioned(
              top: widthScreen * (196 / 375) - 41,
              right: 40,
              child: Container(
                height: 82,
                width: 82,
                decoration: kGradientBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                      height: 82,
                      width: 82,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(82),
                      ),
                      child: Assets.images.profileIcon.image(
                        width: 82,
                        height: 82,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.only(
                  top: widthScreen * (196 / 375) + 61,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              Text("Họ và tên: ", style: AppTextStyle.w600s15(ColorName.black222)),
                              const SizedBox(width: 10),
                              Text("Lê Thanh Quý", style: AppTextStyle.w500s15(ColorName.black000)),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              Text("Ngày sinh: ", style: AppTextStyle.w600s15(ColorName.black222)),
                              const SizedBox(width: 10),
                              Text("14-10-2001", style: AppTextStyle.w500s15(ColorName.black000)),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              Text("Giới tính: ", style: AppTextStyle.w600s15(ColorName.black222)),
                              const SizedBox(width: 10),
                              Text("Nam", style: AppTextStyle.w500s15(ColorName.black000)),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              Text("Số điện thoại: ", style: AppTextStyle.w600s15(ColorName.black222)),
                              const SizedBox(width: 10),
                              Text("0384933379", style: AppTextStyle.w500s15(ColorName.black000)),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              Text("Khoa: ", style: AppTextStyle.w600s15(ColorName.black222)),
                              const SizedBox(width: 10),
                              Text("Công nghệ thông tin", style: AppTextStyle.w500s15(ColorName.black000)),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 16),
                              Text("Lớp: ", style: AppTextStyle.w600s15(ColorName.black222)),
                              const SizedBox(width: 10),
                              Text("19TCLC_DT4", style: AppTextStyle.w500s15(ColorName.black000)),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Danh sách thông tin phương tiện",
                            style: AppTextStyle.w600s15(ColorName.black000),
                          ),
                          const SizedBox(height: 5),
                          Expanded(
                            child: Container(
                              color: ColorName.whiteFff,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      controller.showOkDialog(
                                        title: "92N1-123456",
                                        message: "Xe máy màu đen các kiểu",
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: ColorName.whiteFff,
                                        border: Border(bottom: BorderSide(color: ColorName.grayC7c, width: 0.5)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "92N1-123456",
                                          style: AppTextStyle.w500s13(ColorName.black000),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
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
                              onPressed: controller.resumeScan,
                              fillColor: ColorName.whiteFaf,
                              borderWidth: 1,
                              borderColor: ColorName.primaryColor,
                              child: Text(
                                'Quay lại',
                                style: AppTextStyle.w500s13(ColorName.primaryColor),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: CommonButton(
                              onPressed: controller.confirmScan,
                              borderWidth: 1,
                              borderColor: ColorName.primaryColor,
                              fillColor: ColorName.primaryColor,
                              state: controller.confirmState,
                              child: Text(
                                'Xác nhận',
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
          ],
        ),
      ),
    );
  }
}