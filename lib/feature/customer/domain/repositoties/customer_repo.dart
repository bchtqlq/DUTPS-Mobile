import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/faculties_model.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/customer_update_request.dart';

abstract class CustomerRepo {
  Future<CustomerModel> customerInfo();
  Future<void> customerUpdate(CustomerUpdateRequest request);
  Future<List<FacultyModel>> getAllFaculty();
}
