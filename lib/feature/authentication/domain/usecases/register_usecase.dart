import 'package:dut_packing_system/feature/authentication/data/models/account_model.dart';
import 'package:dut_packing_system/feature/authentication/data/providers/remote/request/register_request.dart';
import '../../../../base/domain/base_usecase.dart';
import '../repositoties/auth_repo.dart';

class RegisterUsecase extends UseCaseIO<RegisterRequest, AccountModel> {
  RegisterUsecase(this._authRepo);
  final AuthRepo _authRepo;

  @override
  Future<AccountModel> build(RegisterRequest input) {
    return _authRepo.register(input);
  }
}
