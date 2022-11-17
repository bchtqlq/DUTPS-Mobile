import 'package:dut_packing_system/feature/customer/data/providers/remote/request/add_vehical_request.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class UpdateVehicalUsecase extends UseCaseIO<Map<int, AddVehicalRequest>, void> {
  UpdateVehicalUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<void> build(Map<int, AddVehicalRequest> input) {
    return _customerRepo.updateVehical(input.keys.first, input.values.first);
  }
}
