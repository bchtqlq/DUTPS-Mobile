import 'package:dut_packing_system/feature/customer/data/providers/remote/request/add_vehical_request.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class AddVehicalUsecase extends UseCaseIO<AddVehicalRequest, void> {
  AddVehicalUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<void> build(AddVehicalRequest input) {
    return _customerRepo.addVehical(input);
  }
}
