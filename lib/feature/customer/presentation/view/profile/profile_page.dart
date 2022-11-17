import 'package:dut_packing_system/base/presentation/base_app_bar.dart';
import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/base/presentation/widgets/common.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/extension/form_builder.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../controller/profile/profile_controller.dart';

class ProfilePage extends BaseWidget<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget onBuild(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScrren = MediaQuery.of(context).size.height;

    final kGradientBoxDecoration = BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.3, 0.9],
        colors: [ColorName.whiteFff, ColorName.primaryColor],
      ),
      borderRadius: BorderRadius.circular(82),
    );
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: controller.isShowAppbar.value
              ? BaseAppBar(
                  title: const Text("Cập nhật thông tin cá nhân"),
                )
              : null,
          body: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              if (!isKeyboardVisible) {
                controller.isKeyBoardOn.value = false;
              } else {
                controller.isKeyBoardOn.value = true;
              }

              return Obx(
                () => IgnorePointer(
                  ignoring: controller.ignoringPointer.value,
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Assets.images.profileBanner.image(width: widthScreen),
                        Positioned(
                          top: widthScreen * (196 / 375) - 41,
                          right: 40,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: (() {}),
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
                        ),
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.only(
                              top: widthScreen * (196 / 375) + 61,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: controller.isKeyBoardOn.value ? 1 : 20,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                                      child: FormBuilder(
                                        key: controller.formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 20),
                                            CommonTextField(
                                              formKey: controller.formKey,
                                              type: FormFieldType.name,
                                              maxLength: 35,
                                              controller: controller.nameTextEditingController,
                                              onTap: controller.hideErrorMessage,
                                              onChanged: (_) {
                                                controller.updateLoginButtonState();
                                              },
                                            ),
                                            CommonDateTimePicker(
                                              onPressed: controller.hideErrorMessage,
                                              title: "Ngày sinh",
                                              value: controller.birthdayString.value.isNotEmpty
                                                  ? controller.birthdayString.value
                                                  : null,
                                              context: context,
                                              callback: (birthday, birthdayString) {
                                                controller.customer.value.birthday = birthday;
                                                controller.birthdayString.value = birthdayString;
                                              },
                                            ),
                                            const SizedBox(height: 2),
                                            gender(context),
                                            const SizedBox(height: 2),
                                            CommonTextField(
                                              formKey: controller.formKey,
                                              type: FormFieldType.phone,
                                              maxLength: 13,
                                              controller: controller.phoneTextEditingController,
                                              onTap: controller.hideErrorMessage,
                                              onChanged: (_) {
                                                controller.updateLoginButtonState();
                                              },
                                            ),
                                            const SizedBox(height: 2),
                                            CommonTextField(
                                              formKey: controller.formKey,
                                              type: FormFieldType.activityClass,
                                              maxLength: 13,
                                              controller: controller.classTextEditingController,
                                              onTap: controller.hideErrorMessage,
                                              onChanged: (_) {
                                                controller.updateLoginButtonState();
                                              },
                                            ),
                                            const SizedBox(height: 2),
                                            const SizedBox(height: 5),
                                            faculty(context),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Obx(
                                  () => CommonBottomError(text: controller.errorMessage.value),
                                ),
                                Obx(
                                  () => CommonBottomButton(
                                    text: 'Cập nhật',
                                    onPressed: () => controller.onUpdate(context),
                                    pressedOpacity: controller.isDisableButton.value ? 1 : 0.4,
                                    fillColor:
                                        controller.isDisableButton.value ? ColorName.gray838 : ColorName.primaryColor,
                                    state: controller.updateState,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (controller.pageLoading.value)
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget gender(BuildContext context) {
    return CommonDropDown(
      title: "Giới tính",
      value: controller.customer.value.gender == -1
          ? null
          : controller.customer.value.gender == 1
              ? "Nam"
              : "Nữ",
      onPressed: (() {
        controller.hideErrorMessage();
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 250,
              color: ColorName.whiteFaf,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      controller.customer.value.gender = 1;
                      controller.customer.refresh();
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
                        ),
                      ),
                      child: Text(
                        "Nam",
                        style: AppTextStyle.w400s15(ColorName.black000),
                      ),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      controller.customer.value.gender = 2;
                      controller.customer.refresh();
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
                        ),
                      ),
                      child: Text(
                        "Nữ",
                        style: AppTextStyle.w400s15(ColorName.black000),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget faculty(BuildContext context) {
    return CommonDropDown(
      title: "Khoa",
      value: controller.customer.value.falcultyName != null
          ? controller.customer.value.falcultyName!.isEmpty
              ? null
              : controller.customer.value.falcultyName
          : null,
      onPressed: (() async {
        controller.hideErrorMessage();
        await controller.loadData();
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 350,
              color: ColorName.whiteFaf,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 50),
                itemCount: controller.faculties.length,
                itemBuilder: (context, index) => CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    controller.customer.value.facultyId = controller.faculties[index].id;
                    controller.customer.value.falcultyName = controller.faculties[index].name;
                    controller.customer.refresh();
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.5, color: ColorName.grayBdb),
                      ),
                    ),
                    child: Text(
                      controller.faculties[index].name!,
                      style: AppTextStyle.w400s15(ColorName.black000),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
