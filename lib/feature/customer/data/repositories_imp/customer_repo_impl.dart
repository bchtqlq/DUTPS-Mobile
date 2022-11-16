import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/faculties_model.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/customer_api.dart';
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
}
