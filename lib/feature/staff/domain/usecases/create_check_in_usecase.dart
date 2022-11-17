import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_in_request.dart';
import 'package:dut_packing_system/feature/staff/domain/repositoties/staff_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class CreateCheckInUsecase extends UseCaseIO<CreateCheckInRequest, void> {
  CreateCheckInUsecase(this._staffRepo);
  final StaffRepo _staffRepo;

  @override
  Future<void> build(CreateCheckInRequest input) {
    return _staffRepo.createCheckIn(input);
  }
}
