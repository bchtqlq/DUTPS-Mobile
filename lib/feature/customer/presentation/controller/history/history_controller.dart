import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/feature/authentication/data/models/account_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/history_model.dart';
import 'package:dut_packing_system/feature/customer/domain/usecases/get_history_usecase.dart';
import 'package:dut_packing_system/utils/services/storage_service.dart';
import 'package:flutter/foundation.dart';

class HistoryController extends BaseController {
  HistoryController(this._storageService, this._getHistoryUsecase);

  final StorageService _storageService;
  final GetHistoryUsecase _getHistoryUsecase;

  var loadPageState = true.obs;
  var account = AccountModel();
  RxList<HistoryModel> historys = <HistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPage();
  }

  void loadPage() {
    _storageService.getToken().then((value) {
      account = AccountModel.fromJson(jsonDecode(value));
      _getHistoryUsecase.execute(
        observer: Observer(
          onSubscribe: () {
            loadPageState.value = true;
          },
          onSuccess: (listHistory) async {
            loadPageState.value = false;
            historys.value = listHistory.getListHistory();
          },
          onError: (e) async {
            if (e is DioError) {
              if (e.response != null) {
                print(e.response!.data['errors'].toString());
              } else {
                print(e.message);
              }
            }
            if (kDebugMode) {
              print(e.toString());
            }
            loadPage();
          },
        ),
        input: account.username!,
      );
    });
  }
}
