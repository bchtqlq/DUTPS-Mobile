import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../base/presentation/base_app_bar.dart';
import '../../../../../base/presentation/widgets/common.dart';
import '../../../../../utils/extension/form_builder.dart';
import '../../../../../utils/gen/colors.gen.dart';
import '../../controller/forgot_password/forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: const Text('Quên mật khẩu'),
        ),
        body: Obx(
          () => IgnorePointer(
            ignoring: controller.ignoringPointer.value,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
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
                            type: FormFieldType.username,
                            controller: controller.phoneTextEditingController,
                            onTap: controller.hideErrorMessage,
                            onChanged: (_) {
                              controller.updateLoginButtonState();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () =>
                        CommonBottomError(text: controller.errorMessage.value),
                  ),
                  Obx(
                    () => CommonBottomButton(
                      text: 'Tiếp tục',
                      onPressed: controller.onTapForgotPassword,
                      pressedOpacity:
                          controller.isDisableButton.value ? 1 : 0.4,
                      fillColor: controller.isDisableButton.value
                          ? ColorName.gray838
                          : ColorName.primaryColor,
                      state: controller.forgotPassState,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
