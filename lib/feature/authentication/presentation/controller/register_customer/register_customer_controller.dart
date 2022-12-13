import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_system/feature/authentication/data/providers/remote/request/register_request.dart';
import 'package:dut_packing_system/feature/authentication/domain/usecases/register_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_system/utils/config/app_navigation.dart';
import 'package:dut_packing_system/utils/extension/form_builder.dart';
import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../base/presentation/base_controller.dart';

class RegisterCustomerController extends BaseController {
  RegisterCustomerController(this._registerUsecase, this._storageService, this._getCustomerInfoUsecase);

  final RegisterUsecase _registerUsecase;
  final StorageService _storageService;
  final GetCustomerInfoUsecase _getCustomerInfoUsecase;

  final usernameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmPasswordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final registerState = BaseState();

  String get _email => emailTextEditingController.text;
  String get _username => usernameTextEditingController.text;
  String get _password => passwordTextEditingController.text;
  String get _confirmPassword => confirmPasswordTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;
  final isShowConfirmPassword = true.obs;

  @override
  void onClose() {
    usernameTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.onClose();
  }

  void onTapShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  void onTapShowConfirmPassword() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateRegisterButtonState() {
    isDisableButton.value = _username.isEmpty || _password.isEmpty || _confirmPassword.isEmpty || _email.isEmpty;
  }

  void onTapRegister(BuildContext context) {
    try {
      final fbs = formKey.formBuilderState!;
      final userNameField = FormFieldType.username.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      final confirmPassword = FormFieldType.confirmPassword.field(fbs);
      final emailField = FormFieldType.email.field(fbs);
      [
        userNameField,
        emailField,
        passwordField,
        confirmPassword,
      ].validateFormFields();
      if (_password != _confirmPassword) {
        _showToastMessage('Mật khẩu không trùng khớp');
        return;
      }

      if (registerState.isLoading) return;
      _registerUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            registerState.onLoading();
            ignoringPointer.value = true;
            hideErrorMessage();
          },
          onSuccess: (account) {
            registerState.onSuccess();
            account.roleId = 30;
            _storageService.setToken(account.toJson().toString());

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
                  registerState.onSuccess();
                },
              ),
            );
          },
          onError: (e) {
            if (e is DioError) {
              if (e.response != null) {
                _showToastMessage(e.response!.data['message'].toString());
              } else {
                _showToastMessage(e.message);
              }
            }
            if (kDebugMode) {
              print(e.toString());
            }
            ignoringPointer.value = false;
            registerState.onSuccess();
          },
        ),
        input: RegisterRequest(
          _username.trim(),
          _password.trim(),
          _email.trim(),
          _confirmPassword.trim(),
        ),
      );
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void _showToastMessage(String message) {
    registerState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }

  void resetDataTextField() {
    hideErrorMessage();
    passwordTextEditingController.text = '';
  }
}
