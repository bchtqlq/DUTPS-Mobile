import 'package:dut_packing_system/feature/customer/data/models/ch%E1%BA%B9ck_in_model.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetCheckInUsecase extends UseCase<CheckInModel> {
  GetCheckInUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<CheckInModel> build() {
    return _customerRepo.getCheckIn();
  }
}
