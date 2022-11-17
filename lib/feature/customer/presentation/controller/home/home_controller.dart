import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/feature/customer/data/models/ch%E1%BA%B9ck_in_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_check_in_usecase.dart';
import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:flutter/foundation.dart';

class HomeController extends BaseController {
  HomeController(this._storageService, this._getCheckInUsecase);

  final StorageService _storageService;
  final GetCheckInUsecase _getCheckInUsecase;

  var customer = CustomerModel().obs;
  var checkOutString = "".obs;

  Rx<VehicalModel> vehicalQRCode = VehicalModel().obs;

  RxList<VehicalModel> vehicals = <VehicalModel>[].obs;

  Rx<int> selectIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    _storageService.getCustomer().then((value) {
      customer.value = CustomerModel.fromJson(jsonDecode(value));
      vehicals.value = (customer.value.vehicals ?? <VehicalModel>[]) as List<VehicalModel>;
      if (vehicals.isNotEmpty) {
        vehicalQRCode.value = vehicals.first;
      }
    });
  }

  void selectVehical(int index) {
    selectIndex.value = index;
    vehicalQRCode.value = vehicals[index];
  }

  var checkOutState = false.obs;
  var viewCheckOut = false.obs;

  void closeViewCheckOut() {
    viewCheckOut.value = false;
  }

  void checkOut() {
    _getCheckInUsecase.execute(
      observer: Observer(
        onSubscribe: () {
          checkOutState.value = true;
        },
        onSuccess: (checkInModel) async {
          checkOutString.value = checkInModel.toJson().toString();
          checkOutState.value = false;
          viewCheckOut.value = true;
          print(checkOutString);
        },
        onError: (e) {
          checkOutState.value = false;
          showOkDialog(
            title: "Nhận mã đi ra thất bại",
            message: "Hiện tại không có mã đi ra.\nVui lòng thử lại sau",
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
    );
  }
}
