import 'package:dut_packing_system/feature/customer/data/providers/remote/request/change_password_request.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class ChangePasswordUsecase extends UseCaseIO<ChangePasswordRequest, void> {
  ChangePasswordUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<void> build(ChangePasswordRequest input) {
    return _customerRepo.changePassword(input);
  }
}
