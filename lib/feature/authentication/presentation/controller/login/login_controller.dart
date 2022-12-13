import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_system/feature/authentication/data/providers/remote/request/username_password_request.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_system/utils/config/app_navigation.dart';
import 'package:dut_packing_system/utils/extension/form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../base/presentation/base_controller.dart';
import '../../../../../utils/services/storage_service.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginController extends BaseController {
  LoginController(this._loginUsecase, this._storageService, this._getCustomerInfoUsecase);

  final LoginUsecase _loginUsecase;
  final StorageService _storageService;
  final GetCustomerInfoUsecase _getCustomerInfoUsecase;

  final usernameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final loginState = BaseState();

  String get _username => usernameTextEditingController.text;
  String get _password => passwordTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      // test user
      usernameTextEditingController.text = 'quylt123';
      passwordTextEditingController.text = '123123';

      // test staff
      usernameTextEditingController.text = 'admin';
      passwordTextEditingController.text = 'Pa\$\$w0rd';
    }
  }

  @override
  void onClose() {
    usernameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.onClose();
  }

  void onTapShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateLoginButtonState() {
    isDisableButton.value = _username.isEmpty || _password.isEmpty;
  }

  void onTapLogin(BuildContext context) {
    try {
      final fbs = formKey.formBuilderState!;
      final phoneField = FormFieldType.username.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      [
        phoneField,
        passwordField,
      ].validateFormFields();

      if (loginState.isLoading) return;
      _loginUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            loginState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (account) {
            ignoringPointer.value = false;

            _storageService.setToken(account.toJson().toString());
            if (account.roleId == 30) {
              _getCustomerInfoUsecase.execute(
                observer: Observer(
                  onSubscribe: () {},
                  onSuccess: (customer) async {
                    print(customer.toJson());
                    await _storageService.setCustomer(customer.toJson().toString());
                    if (customer.name != null &&
                        customer.gender != null &&
                        customer.birthday != null &&
                        customer.phoneNumber != null &&
                        customer.activityClass != null &&
                        customer.facultyId != null) {
                      N.toHome();
                    } else {
                      N.toProfile();
                    }
                  },
                  onError: (e) async {
                    if (e is DioError) {
                      _showToastMessage(e.message);
                    }
                    if (kDebugMode) {
                      print(e.toString());
                    }
                    ignoringPointer.value = false;
                    loginState.onSuccess();
                  },
                ),
              );
            } else {
              N.toStaffPage();
            }
          },
          onError: (e) {
            if (e is DioError) {
              _showToastMessage(e.message);
            }
            if (kDebugMode) {
              print(e.toString());
            }
            ignoringPointer.value = false;
            loginState.onSuccess();
          },
        ),
        input: UsernamePasswordRequest(
          _username.trim(),
          _password.trim(),
        ),
      );
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void _showToastMessage(String message) {
    loginState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }

  void resetDataTextField() {
    hideErrorMessage();
    passwordTextEditingController.text = '';
  }
}
