import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_system/feature/customer/data/models/ch%E1%BA%B9ck_in_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/faculties_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/history_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/list_history_model.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/add_vehical_request.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/change_password_request.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/request/customer_update_request.dart';
import 'package:retrofit/http.dart';

part 'customer_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class CustomerAPI {
  factory CustomerAPI(Dio dioBuilder) = _CustomerAPI;

  @GET('/Profile')
  Future<CustomerModel> customerInfo();

  @GET('/Common/Faculties')
  Future<List<FacultyModel>> getAllFaculty();

  @POST('/Profile')
  Future<void> customerUpdate(@Body() CustomerUpdateRequest request);

  @POST('/Vehicals')
  Future<void> addVehical(@Body() AddVehicalRequest request);

  @PUT('/Vehicals/{id}')
  Future<void> updateVehical(@Path("id") int id, @Body() AddVehicalRequest request);

  @DELETE('/Vehicals/{id}')
  Future<void> deleteVehical(@Path("id") int id);

  @POST('/Profile/ChangePassword')
  Future<void> changePassword(@Body() ChangePasswordRequest request);

  @GET('/CheckIns/GetByUsername')
  Future<CheckInModel> getCheckIn();

  @GET('/CheckIns/History')
  Future<ListHistoryModel> getHistory(@Query("CustomerUsername") String customerUsername);
  
}
