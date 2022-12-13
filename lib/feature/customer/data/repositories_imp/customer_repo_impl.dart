import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/feature/customer/data/models/ch%E1%BA%B9ck_in_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/faculties_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/history_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/list_history_model.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/customer_api.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/add_vehical_request.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/change_password_request.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/customer_update_request.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

class CustomerRepoImpl implements CustomerRepo {
  final _customerAPI = Get.find<CustomerAPI>();

  @override
  Future<CustomerModel> customerInfo() {
    return _customerAPI.customerInfo();
  }

  @override
  Future<void> customerUpdate(CustomerUpdateRequest request) {
    return _customerAPI.customerUpdate(request);
  }

  @override
  Future<List<FacultyModel>> getAllFaculty() {
    return _customerAPI.getAllFaculty();
  }

  @override
  Future<void> addVehical(AddVehicalRequest request) {
    return _customerAPI.addVehical(request);
  }

  @override
  Future<void> updateVehical(int id, AddVehicalRequest request) {
    return _customerAPI.updateVehical(id, request);
  }

  @override
  Future<void> deleteVehical(int id) {
    return _customerAPI.deleteVehical(id);
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) {
    return _customerAPI.changePassword(request);
  }

  @override
  Future<CheckInModel> getCheckIn() {
    return _customerAPI.getCheckIn();
  }

  @override
  Future<ListHistoryModel> getHistory(String customerUsername) {
    return _customerAPI.getHistory(customerUsername);
  }
}
