import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class DeleteVehicalUsecase extends UseCaseIO<int, void> {
  DeleteVehicalUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<void> build(int input) {
    return _customerRepo.deleteVehical(input);
  }
}
