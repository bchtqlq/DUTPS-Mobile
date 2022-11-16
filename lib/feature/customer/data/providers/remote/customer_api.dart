import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/data/models/faculties_model.dart';
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

  @PUT('/Profile')
  Future<void> customerUpdate(@Body() CustomerUpdateRequest request);
}
