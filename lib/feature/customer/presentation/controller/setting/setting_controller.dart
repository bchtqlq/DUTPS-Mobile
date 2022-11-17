import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/base/presentation/widgets/common.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/change_password_request.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/change_password_usecase.dart';
import 'package:dut_packing_system/utils/config/app_navigation.dart';
import 'package:dut_packing_system/utils/config/app_text_style.dart';
import 'package:dut_packing_system/utils/extension/form_builder.dart';
import 'package:dut_packing_system/utils/gen/assets.gen.dart';
import 'package:dut_packing_system/utils/gen/colors.gen.dart';
import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SettingController extends BaseController {
  SettingController(this._storageService, this._changePasswordUsecase);

  final StorageService _storageService;
  final ChangePasswordUsecase _changePasswordUsecase;

  void logout() {
    showOkCancelDialog(
      cancelText: "Huỷ",
      okText: "Đăng xuất",
      message: "Bạn chắc chắn muốn đăng xuất khỏi hệ thống?",
      title: "Đăng xuất",
    ).then((value) async {
      if (value == OkCancelResult.ok) {
        await _storageService.removeToken();
        await _storageService.removeCustomer();
        N.toWelcomePage();
      }
    });
  }

  TextEditingController passwordTextFieldController = TextEditingController();
  TextEditingController oldPasswordTextFieldController = TextEditingController();
  TextEditingController newPasswordTextFieldController = TextEditingController();
  var isShowOldPassword = true.obs;
  var isShowNewPassword = true.obs;
  var isShowConfirmPassword = true.obs;
  var changePasswordState = false.obs;

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Đổi mật khẩu',
            style: AppTextStyle.w700s20(ColorName.black000),
          ),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextField(
                  type: FormFieldType.oldPassword,
                  controller: oldPasswordTextFieldController,
                  textInputAction: TextInputAction.next,
                  obscureText: isShowOldPassword.value,
                  suffixIcon: isShowOldPassword.value
                      ? Assets.images.showPassIcon.image(scale: 3)
                      : Assets.images.hidePassIcon.image(scale: 3),
                  onPressedSuffixIcon: () {
                    isShowOldPassword.value = !isShowOldPassword.value;
                  },
                  onSubmitted: (_) {},
                ),
                CommonTextField(
                  type: FormFieldType.newPassword,
                  controller: newPasswordTextFieldController,
                  textInputAction: TextInputAction.next,
                  obscureText: isShowNewPassword.value,
                  suffixIcon: isShowNewPassword.value
                      ? Assets.images.showPassIcon.image(scale: 3)
                      : Assets.images.hidePassIcon.image(scale: 3),
                  onPressedSuffixIcon: () {
                    isShowNewPassword.value = !isShowNewPassword.value;
                  },
                  onSubmitted: (_) {},
                ),
                CommonTextField(
                  type: FormFieldType.confirmPassword,
                  controller: passwordTextFieldController,
                  textInputAction: TextInputAction.done,
                  obscureText: isShowConfirmPassword.value,
                  suffixIcon: isShowConfirmPassword.value
                      ? Assets.images.showPassIcon.image(scale: 3)
                      : Assets.images.hidePassIcon.image(scale: 3),
                  onPressedSuffixIcon: () {
                    isShowConfirmPassword.value = !isShowConfirmPassword.value;
                  },
                  onSubmitted: (_) {},
                ),
              ],
            ),
          ),
          actions: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(
                'Hủy',
                style: AppTextStyle.w600s16(ColorName.primaryColor),
              ),
              onPressed: () {
                passwordTextFieldController.text = "";
                newPasswordTextFieldController.text = "";
                oldPasswordTextFieldController.text = "";
                Navigator.pop(context);
              },
            ),
            CupertinoButton(
              child: Text(
                'Xác nhận',
                style: AppTextStyle.w600s16(ColorName.black000),
              ),
              onPressed: () {
                if (passwordTextFieldController.text.trim().length >= 6 &&
                    oldPasswordTextFieldController.text.trim().length >= 6 &&
                    newPasswordTextFieldController.text.trim().length >= 6) {
                  if (newPasswordTextFieldController.text.trim() != passwordTextFieldController.text.trim()) {
                    showOkDialog(
                      message: "Mật khẩu không trùng khớp",
                      title: "Đổi mật khẩu thất bại",
                    );
                  } else {
                    showOkCancelDialog(
                      cancelText: "Huỷ",
                      okText: "Đổi mật khẩu",
                      message: "Bạn chắc chắn muôn thay đổi mật khẩu hiện tại?",
                      title: "Xác nhận",
                    ).then((value) async {
                      if (value == OkCancelResult.ok) {
                        hideKeyboard();
                        changepassword(ChangePasswordRequest(
                          oldPasswordTextFieldController.text.trim(),
                          newPasswordTextFieldController.text.trim(),
                          passwordTextFieldController.text.trim(),
                        ));
                        passwordTextFieldController.text = "";
                        newPasswordTextFieldController.text = "";
                        oldPasswordTextFieldController.text = "";
                        Navigator.pop(context);
                      }
                    });
                  }
                } else {
                  showOkDialog(
                    message: "Mật khẩu yêu cầu tối thiểu 6 ký tự",
                    title: "Đổi mật khẩu thất bại",
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void changepassword(ChangePasswordRequest request) {
    _changePasswordUsecase.execute(
      observer: Observer(
        onSubscribe: () {
          changePasswordState.value = true;
        },
        onSuccess: (_) async {
          showOkDialog(
            message: "Mật khẩu của bạn đã được thay đổi",
            title: "Đổi mật khẩu thành công",
          );
          changePasswordState.value = false;
        },
        onError: (e) async {
          if (e is DioError) {
            if (e.response != null) {
              showOkDialog(
                message: e.response!.data['errors'].toString(),
                title: "Đổi mật khẩu thất bại",
              );
            } else {
              showOkDialog(
                message: e.message,
                title: "Đổi mật khẩu thất bại",
              );
            }
          }
          if (kDebugMode) {
            print(e.toString());
          }
          changePasswordState.value = false;
        },
      ),
      input: request,
    );
  }

  void toHistory() {
    N.toHistory();
  }
}
