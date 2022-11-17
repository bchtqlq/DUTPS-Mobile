import 'dart:convert';
import 'package:dut_packing_system/feature/customer/data/models/ch%E1%BA%B9ck_in_model.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_out_request.dart';
import 'package:dut_packing_system/feature/staff/domain/usecases/create_check_out_usecase.dart';
import "package:intl/intl.dart";

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_in_request.dart';
import 'package:dut_packing_system/feature/staff/domain/usecases/create_check_in_usecase.dart';
import 'package:dut_packing_system/utils/config/app_navigation.dart';
import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class StaffController extends BaseController {
  StaffController(this._storageService, this._createCheckInUsecase, this._createCheckOutUsecase);

  final StorageService _storageService;
  final CreateCheckInUsecase _createCheckInUsecase;
  final CreateCheckOutUsecase _createCheckOutUsecase;

  QRViewController? _qrCodecontroller;

  var isChecked = false.obs;

  var isCheckIn = true.obs;

  var isScan = false.obs;

  var confirmState = false.obs;

  var customer = CustomerModel().obs;
  var checkIn = CheckInModel().obs;

  @override
  void onClose() {
    super.onClose();
    _qrCodecontroller?.dispose();
  }

  void onQRViewCreated(QRViewController qrCodecontroller) {
    _qrCodecontroller = qrCodecontroller;
    _qrCodecontroller?.resumeCamera();
    _qrCodecontroller?.pauseCamera();
    _qrCodecontroller?.scannedDataStream.listen(
      (scanData) {
        var result = scanData.code ?? "";
        if (result != "") {
          print(result);
          _qrCodecontroller?.pauseCamera();
          if (isCheckIn.value) {
            try {
              customer.value = CustomerModel.fromJsonWithVehical(jsonDecode(result));
              isChecked.value = true;
            } catch (e) {
              showOkDialog(title: "Mã không hợp lệ", message: "Đây không phải là một mã hợp lệ vui lòng kiểm tra lại");
              pauseScan();
            }
          } else {
            try {
              checkIn.value = CheckInModel.fromJson(jsonDecode(result));
              isChecked.value = true;
            } catch (e) {
              showOkDialog(title: "Mã không hợp lệ", message: "Đây không phải là một mã hợp lệ vui lòng kiểm tra lại");
              pauseScan();
            }
          }
        }
      },
    );
  }

  void resumeScan() {
    _qrCodecontroller?.resumeCamera();
    isChecked.value = false;
  }

  void startScan(bool checkIn) {
    _qrCodecontroller?.resumeCamera();
    isChecked.value = false;
    isScan.value = true;
    isCheckIn.value = checkIn;
  }

  void pauseScan() {
    _qrCodecontroller?.pauseCamera();
    isChecked.value = false;
    isScan.value = false;
    confirmState.value = false;
  }

  void confirmScan() {
    DateTime now = DateTime.now();
    String timeNow = DateFormat('yyyy-MM-ddTHH:mm:ss\'Z\'').format(now);
    if (isCheckIn.value) {
      _createCheckInUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            confirmState.value = true;
          },
          onSuccess: (_) async {
            await showOkDialog(
              title: "Đi vào",
              message: "Xác nhận thành công",
            );
            pauseScan();
          },
          onError: (e) {
            confirmState.value = false;
            showOkDialog(
              title: "Đi vào",
              message: "Xác nhận không thành công vui lòng thực hiện lại",
            );
            if (e is DioError) {
              if (e.response != null) {
                print(e.response!.data['errors'].toString());
                print(e.response!.data['error'].toString());
              } else {
                print(e.message);
              }
            }
            if (kDebugMode) {
              print(e.toString());
            }
            if (kDebugMode) {
              print(e);
            }
          },
        ),
        input: CreateCheckInRequest(customer.value.username, customer.value.vehical!.id, timeNow),
      );
    } else {
      _createCheckOutUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            confirmState.value = true;
          },
          onSuccess: (_) async {
            await showOkDialog(
              title: "Đi ra",
              message: "Xác nhận thành công",
            );
            pauseScan();
          },
          onError: (e) {
            confirmState.value = false;
            showOkDialog(
              title: "Đi ra",
              message: "Xác nhận không thành công vui lòng thực hiện lại",
            );
            if (e is DioError) {
              if (e.response != null) {
                print(e.response!.data['errors'].toString());
                print(e.response!.data['error'].toString());
              } else {
                print(e.message);
              }
            }
            if (kDebugMode) {
              print(e.toString());
            }
            if (kDebugMode) {
              print(e);
            }
          },
        ),
        input: CreateCheckOutRequest(checkIn.value.id, timeNow),
      );
    }
  }

  void logout() {
    showOkCancelDialog(
      cancelText: "Huỷ",
      okText: "Đăng xuất",
      message: "Bạnc chắc chắn muôn đăng xuất khỏi hệ thống?",
      title: "Đăng xuất",
    ).then((value) async {
      if (value == OkCancelResult.ok) {
        await _storageService.removeToken();
        await _storageService.removeCustomer();
        N.toWelcomePage();
      }
    });
  }
}
