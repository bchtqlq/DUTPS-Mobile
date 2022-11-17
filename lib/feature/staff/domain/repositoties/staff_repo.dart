import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_in_request.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_out_request.dart';

abstract class StaffRepo {
  Future<void> createCheckIn(CreateCheckInRequest request);
  Future<void> createCheckOut(CreateCheckOutRequest request);
}
