import 'package:dut_packing_system/feature/customer/data/models/ch%E1%BA%B9ck_in_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/faculties_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/history_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/list_history_model.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/add_vehical_request.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/change_password_request.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/customer_update_request.dart';

abstract class CustomerRepo {
  Future<CustomerModel> customerInfo();
  Future<void> customerUpdate(CustomerUpdateRequest request);
  Future<List<FacultyModel>> getAllFaculty();
  Future<void> addVehical(AddVehicalRequest request);
  Future<void> updateVehical(int id, AddVehicalRequest request);
  Future<void> deleteVehical(int id);
  Future<void> changePassword(ChangePasswordRequest request);
  Future<CheckInModel> getCheckIn();
  Future<ListHistoryModel> getHistory(String customerUsername);
}
