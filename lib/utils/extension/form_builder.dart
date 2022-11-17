import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

typedef MyFormFieldState = FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>;

enum FormFieldType {
  username,
  password,
  newPassword,
  oldPassword,
  confirmPassword,
  email,
  memo,
  name,
  phone,
  activityClass,
  licensePlate,
}

extension FormFieldTypeExtension on FormFieldType {
  String get labelText {
    switch (this) {
      case FormFieldType.username:
        return 'Tài khoản';
      case FormFieldType.name:
        return 'Họ và tên';
      case FormFieldType.phone:
        return 'Số điện thoại';
      case FormFieldType.activityClass:
        return 'Lớp sinh hoạt';
      case FormFieldType.email:
        return 'E-mail';
      case FormFieldType.password:
        return 'Mật khẩu';
      case FormFieldType.newPassword:
        return 'Mật khẩu mới';
      case FormFieldType.oldPassword:
        return 'Mật khẩu hiện tại';
      case FormFieldType.confirmPassword:
        return 'Xác nhận mật khẩu';
      case FormFieldType.memo:
        return 'Mô tả';
      case FormFieldType.licensePlate:
        return 'Biển số xe';
      default:
        return '';
    }
  }

  String get hintText {
    switch (this) {
      case FormFieldType.email:
        return 'NguyenVanA@gmail.com';
      case FormFieldType.licensePlate:
        return '92N1-000000';
      case FormFieldType.username:
        return '';
      default:
        return '';
    }
  }

  TextInputType get keyboardType {
    switch (this) {
      case FormFieldType.username:
        return TextInputType.name;
      case FormFieldType.phone:
        return TextInputType.phone;
      case FormFieldType.memo:
        return TextInputType.multiline;
      default:
        return TextInputType.text;
    }
  }

  MyFormFieldState field(FormBuilderState formBuilderState) {
    final field = formBuilderState.fields[name];
    if (field == null) {
      throw Exception('Cannot detect state of form key');
    }
    return field;
  }

  FormFieldValidator<String?>? validator() {
    List<FormFieldValidator<String?>> validators = [];
    switch (this) {
      case FormFieldType.username:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống tên tài khoản'),
        ];
        break;
      case FormFieldType.phone:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống số điện thoại'),
          FormBuilderValidators.integer(errorText: 'Số điện thoại bao gồm các chữ số'),
          FormBuilderValidators.compose(
            [
              (val) {
                final validNumber = RegExp(r'^[+|0]{1}[0-9]{9,11}$');
                return validNumber.hasMatch(val.toString().trim()) ? null : "Vui lòng nhập vào số điện thoại của bạn";
              },
            ],
          ),
        ];
        break;

      case FormFieldType.name:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống họ và tên'),
        ];
        break;

      case FormFieldType.activityClass:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống lớp sinh hoạt'),
        ];
        break;

      case FormFieldType.email:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống e-mail'),
          FormBuilderValidators.email(errorText: 'Vui lòng nhập đúng định dạng e-mail'),
        ];
        break;
      case FormFieldType.password:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mật khẩu'),
          FormBuilderValidators.minLength(6, errorText: 'Mật khẩu tối thiểu 8 ký tự'),
        ];
        break;
      case FormFieldType.newPassword:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mật khẩu mới'),
          FormBuilderValidators.minLength(6, errorText: 'Mật khẩu tối thiểu 8 ký tự'),
        ];
        break;
      case FormFieldType.oldPassword:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mật khẩu hiện tại'),
          FormBuilderValidators.minLength(6, errorText: 'Mật khẩu tối thiểu 8 ký tự'),
        ];
        break;
      case FormFieldType.confirmPassword:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống mật khẩu xác nhận'),
          FormBuilderValidators.minLength(6, errorText: 'Mật khẩu tối thiểu 6 ký tự'),
        ];
        break;

      case FormFieldType.licensePlate:
        validators = [
          FormBuilderValidators.required(errorText: 'Không được để trống biển số xe'),
        ];
        break;
      case FormFieldType.memo:
        validators = [
          FormBuilderValidators.maxLength(1000, errorText: 'Vượt quá giói hạn số từ'),
          FormBuilderValidators.required(errorText: 'Không được để trống mô tả'),
        ];
        break;
      default:
        return null;
    }
    return FormBuilderValidators.compose(validators);
  }
}

extension FormKeyExtension on GlobalKey<FormBuilderState> {
  FormBuilderState? get formBuilderState {
    return currentState;
  }
}

extension ListFormFieldState on List<MyFormFieldState> {
  void validateFormFields() {
    FocusManager.instance.primaryFocus?.unfocus();
    final isValid = map((e) => e.validate()).reduce((v, e) => v && e);
    if (!isValid) {
      final errorMessage = map(
        (e) => e.errorText == null ? null : '${e.decoration.labelText}: ${e.errorText}',
      ).whereType<String>().toList().join('\n');
      throw Exception(errorMessage);
    }
  }
}
