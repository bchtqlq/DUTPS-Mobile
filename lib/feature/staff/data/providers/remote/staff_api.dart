import 'package:dio/dio.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_in_request.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_out_request.dart';
import 'package:retrofit/http.dart';

part 'staff_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class StaffAPI {
  factory StaffAPI(Dio dioBuilder) = _StaffAPI;

  @POST('/CheckIns/CreateCheckIn')
  Future<void> createCheckIn(@Body() CreateCheckInRequest request);

  @POST('/CheckIns/CreateCheckOut')
  Future<void> createCheckOut(@Body() CreateCheckOutRequest request);
}
