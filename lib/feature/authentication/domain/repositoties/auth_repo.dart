import 'package:dut_packing_system/feature/authentication/data/providers/remote/request/register_request.dart';
import 'package:dut_packing_system/feature/authentication/data/providers/remote/request/username_password_request.dart';

import '../../data/models/account_model.dart';

abstract class AuthRepo {
  Future<AccountModel> login(UsernamePasswordRequest request);
  Future<AccountModel> register(RegisterRequest request);
}
