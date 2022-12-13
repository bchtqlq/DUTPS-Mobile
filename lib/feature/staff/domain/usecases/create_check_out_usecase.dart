import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_in_request.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/request/create_check_out_request.dart';
import 'package:dut_packing_system/feature/staff/domain/repositoties/staff_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class CreateCheckOutUsecase extends UseCaseIO<CreateCheckOutRequest, void> {
  CreateCheckOutUsecase(this._staffRepo);
  final StaffRepo _staffRepo;

  @override
  Future<void> build(CreateCheckOutRequest input) {
    return _staffRepo.createCheckOut(input);
  }
}
