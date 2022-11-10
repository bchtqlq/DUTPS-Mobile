
import 'package:dut_packing_system/feature/authentication/data/providers/remote/request/username_password_request.dart';

import '../../../../base/domain/base_usecase.dart';
import '../../data/models/account_model.dart';
import '../repositoties/auth_repo.dart';

class LoginUsecase extends UseCaseIO<UsernamePasswordRequest, AccountModel> {
  LoginUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<AccountModel> build(UsernamePasswordRequest input) {
    return _authRepo.login(input);
  }
}
