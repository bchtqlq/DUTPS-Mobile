import 'package:dut_packing_system/base/presentation/base_controller.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_in_request.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_out_request.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/staff_api.dart';
import 'package:dut_packing_system/feature/staff/domain/repositoties/staff_repo.dart';

class StaffRepoImpl implements StaffRepo {
  final _staffAPI = Get.find<StaffAPI>();

  @override
  Future<void> createCheckIn(CreateCheckInRequest request) {
    return _staffAPI.createCheckIn(request);
  }

  @override
  Future<void> createCheckOut(CreateCheckOutRequest request) {
    return _staffAPI.createCheckOut(request);
  }
}
