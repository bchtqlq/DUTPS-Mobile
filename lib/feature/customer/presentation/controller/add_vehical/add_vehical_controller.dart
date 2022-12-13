import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/base/presentation/base_widget.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/add_vehical_request.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/add_vehical_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/delete_vehical_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_customer_info_usecase.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/update_vehical_usecase.dart';
import 'package:dut_packing_system/feature/customer/presentation/controller/home/home_controller.dart';
import 'package:dut_packing_system/utils/extension/form_builder.dart';
import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum VehicalPageState { update, add }

class AddVehicalController extends BaseController {
  AddVehicalController(
    this._storageService,
    this._addVehicalUsecase,
    this._getCustomerInfoUsecase,
    this._deleteVehicalUsecase,
    this._updateVehicalUsecase,
  );

  final StorageService _storageService;
  final AddVehicalUsecase _addVehicalUsecase;
  final GetCustomerInfoUsecase _getCustomerInfoUsecase;
  final DeleteVehicalUsecase _deleteVehicalUsecase;
  final UpdateVehicalUsecase _updateVehicalUsecase;

  final memoTextEditingController = TextEditingController();
  final licensePlateTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final updateState = BaseState();

  var pageState = VehicalPageState.add.obs;

  var vehicalUpdateID = -1;

  var isKeyBoardOn = false.obs;

  String get _memo => memoTextEditingController.text;
  String get _licensePlate => licensePlateTextEditingController.text;

  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final errorMessage = ''.obs;
  final isShowPassword = true.obs;

  var customer = CustomerModel().obs;
  RxList<VehicalModel> vehicals = <VehicalModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _storageService.getCustomer().then((value) {
      customer.value = CustomerModel.fromJson(jsonDecode(value));
      vehicals.value = (customer.value.vehicals ?? <VehicalModel>[]) as List<VehicalModel>;
    });
  }

  @override
  void onClose() {
    memoTextEditingController.dispose();
    licensePlateTextEditingController.dispose();
    super.onClose();
  }

  void hideErrorMessage() {
    errorMessage.value = '';
  }

  void updateLoginButtonState() {
    isDisableButton.value = _memo.isEmpty || _licensePlate.isEmpty;
  }

  void loadCustomerInfo() {
    _getCustomerInfoUsecase.execute(
      observer: Observer(
        onSubscribe: () {},
        onSuccess: (result) async {
          licensePlateTextEditingController.text = "";
          memoTextEditingController.text = "";
          print(result.toJson());
          await _storageService.setCustomer(result.toJson().toString());
          customer.value = result;
          vehicals.value = (customer.value.vehicals ?? <VehicalModel>[])
              .map(
                (e) => VehicalModel.fromJson(e),
              )
              .toList();
          Get.find<HomeController>().loadData();
          updateState.onSuccess();
          ignoringPointer.value = false;
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

  void onAdd() {
    try {
      final fbs = formKey.formBuilderState!;
      final memoField = FormFieldType.memo.field(fbs);
      final licensePlateField = FormFieldType.licensePlate.field(fbs);
      [
        memoField,
        licensePlateField,
      ].validateFormFields();
      _addVehicalUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            ignoringPointer.value = true;
            updateState.onLoading();
            hideErrorMessage();
          },
          onSuccess: (_) async {
            loadCustomerInfo();
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
        input: AddVehicalRequest(
          _licensePlate,
          _memo,
        ),
      );

      if (updateState.isLoading) return;
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void toUpdate(VehicalModel vehicalModel) {
    pageState.value = VehicalPageState.update;
    licensePlateTextEditingController.text = vehicalModel.licensePlate!;
    memoTextEditingController.text = vehicalModel.description!;
    vehicalUpdateID = vehicalModel.id!;
  }

  void toAdd() {
    pageState.value = VehicalPageState.add;
    licensePlateTextEditingController.text = "";
    memoTextEditingController.text = "";
  }

  void onDeleteVehical(VehicalModel vehicalModel) {
    showOkCancelDialog(
      title: "Xóa phương tiện",
      message: "Bạn chắc chắn muốn xóa phương tiện (${vehicalModel.licensePlate}) này?",
      okText: "Xác nhận",
      cancelText: "Hủy",
    ).then((value) {
      if (value == OkCancelResult.ok) {
        _deleteVehicalUsecase.execute(
          observer: Observer(
            onSubscribe: () {
              ignoringPointer.value = true;
              updateState.onLoading();
              hideErrorMessage();
            },
            onSuccess: (_) async {
              loadCustomerInfo();
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
          input: vehicalModel.id!,
        );
      }
    });
  }

  void onUpdate() {
    try {
      final fbs = formKey.formBuilderState!;
      final memoField = FormFieldType.memo.field(fbs);
      final licensePlateField = FormFieldType.licensePlate.field(fbs);
      [
        memoField,
        licensePlateField,
      ].validateFormFields();

      if (updateState.isLoading) return;
      var updateInput = <int, AddVehicalRequest>{};
      updateInput[vehicalUpdateID] = AddVehicalRequest(
        _licensePlate,
        _memo,
      );
      _updateVehicalUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            ignoringPointer.value = true;
            updateState.onLoading();
            hideErrorMessage();
          },
          onSuccess: (_) async {
            loadCustomerInfo();
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
        input: updateInput,
      );
    } on Exception catch (e) {
      isDisableButton.value = true;
    }
  }

  void _showToastMessage(String message) {
    updateState.onError(message);
    ignoringPointer.value = false;
    errorMessage.value = message;
  }
}
