import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:dut_packing_system/feature/authentication/data/providers/remote/request/register_request.dart';
import 'package:dut_packing_system/feature/authentication/data/providers/remote/request/username_password_request.dart';
import 'package:retrofit/http.dart';

import '../../models/account_model.dart';

part 'auth_api.g.dart';

@RestApi(parser: Parser.DartJsonMapper)
abstract class AuthAPI {
  factory AuthAPI(Dio dioBuilder) = _AuthAPI;

  @POST('/Auth/Login')
  Future<AccountModel> login(@Body() UsernamePasswordRequest request);

  @POST('/Auth/Register')
  Future<AccountModel> register(@Body() RegisterRequest request);
}
