import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/faculties_model.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/customer_update_request.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_faculties_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/update_customer_usecase.dart';
import 'package:dut_packing_system/utils/config/app_navigation.dart';
import 'package:dut_packing_system/utils/extension/form_builder.dart';
import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ProfileController extends BaseController<bool> {
  ProfileController(
    this._storageService,
    this._getFacultiesUsecase,
    this._updateCustomerUsecase,
    this._getCustomerInfoUsecase,
  );

  final StorageService _storageService;
  final GetFacultiesUsecase _getFacultiesUsecase;
  final UpdateCustomerUsecase _updateCustomerUsecase;
  final GetCustomerInfoUsecase _getCustomerInfoUsecase;

  final phoneTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  final classTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final updateState = BaseState();
  final pageLoading = false.obs;

  var isKeyBoardOn = false.obs;

  RxList<FacultyModel> faculties = RxList<FacultyModel>.empty();

  var birthdayString = "".obs;

  String get _phone => phoneTextEditingController.text;
  String get _class => classTextEditingController.text;
  String get _name => nameTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;

  var isShowAppbar = false.obs;

  var customer = CustomerModel().obs;

  @override
  void onInit() {
    super.onInit();
    if (input) {
      isShowAppbar.value = true;
    }
    _storageService.getCustomer().then((value) {
      customer.value = CustomerModel.fromJson(jsonDecode(value));
      if (input) {
        phoneTextEditingController.text = customer.value.phoneNumber!;
        nameTextEditingController.text = customer.value.name!;
        classTextEditingController.text = customer.value.activityClass!;

        birthdayString.value = "${customer.value.birthday!.year.toString()}"
            "-${customer.value.birthday!.month.toString().padLeft(2, '0')}"
            "-${customer.value.birthday!.day.toString().padLeft(2, '0')}";
      }
    });
  }

  Future<void> loadData() async {
    if (faculties.isEmpty) {
      await _getFacultiesUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            ignoringPointer.value = true;
            pageLoading.value = true;
          },
          onSuccess: (data) {
            ignoringPointer.value = false;
            pageLoading.value = false;
            faculties.value = data;
          },
          onError: (e) async {
            if (kDebugMode) {
              print(e.toString());
            }
            loadData();
          },
        ),
      );
    }
  }

  @override
  void onClose() {
    phoneTextEditingController.dispose();
    classTextEditingController.dispose();
    nameTextEditingController.dispose();
    super.onClose();
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateLoginButtonState() {
    isDisableButton.value = _phone.isEmpty || _class.isEmpty || _name.isEmpty;
  }

  void onUpdate(BuildContext context) {
    try {
      final fbs = formKey.formBuilderState!;
      final phoneField = FormFieldType.phone.field(fbs);
      final nameField = FormFieldType.name.field(fbs);
      final classField = FormFieldType.activityClass.field(fbs);
      [
        phoneField,
        nameField,
        classField,
      ].validateFormFields();

      if (birthdayString.value.isEmpty ||
          customer.value.gender == -1 ||
          customer.value.facultyId == null ||
          customer.value.facultyId == "") {
        _showToastMessage("Vui lòng điền đầy đủ thông tin");
        return;
      }
      customer.value.name = _name;
      customer.value.phoneNumber = _phone;
      customer.value.activityClass = _class;

      if (updateState.isLoading) return;
      _updateCustomerUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            ignoringPointer.value = true;
            updateState.onLoading();
            hideErrorMessage();
          },
          onSuccess: (_) async {
            ignoringPointer.value = false;
            updateState.onSuccess();
            loadCustomerInfo();
          },
          onError: (e) async {
            if (e is DioError) {
              if (e.response != null) {
                _showToastMessage(e.response!.data['errors'].toString());
                print(e.response!.data['errors'].toString());
              } else {
                _showToastMessage(e.message);
              }
            }
            if (kDebugMode) {
              print(e.toString());
            }
            ignoringPointer.value = false;
            updateState.onSuccess();
          },
        ),
        input: CustomerUpdateRequest(
          customer.value.name,
          customer.value.gender,
          birthdayString.value,
          customer.value.phoneNumber,
          customer.value.activityClass,
          customer.value.facultyId,
        ),
      );
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void loadCustomerInfo() {
    _getCustomerInfoUsecase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (result) async {
          await _storageService.setCustomer(result.toJson().toString());
          N.toHome();
        },
        onError: (e) async {
          if (e is DioError) {
            if (e.response != null) {
              _showToastMessage(e.response!.data['errors'].toString());
            } else {
              _showToastMessage(e.message);
            }
          }
          if (kDebugMode) {
            print(e.toString());
          }
          ignoringPointer.value = false;
          updateState.onSuccess();
        },
      ),
    );
  }

  void _showToastMessage(String message) {
    updateState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }
}
