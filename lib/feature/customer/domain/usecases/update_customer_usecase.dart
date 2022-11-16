import 'package:dut_packing_system/feature/customer/data/providers/remote/request/customer_update_request.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class UpdateCustomerUsecase extends UseCaseIO<CustomerUpdateRequest, void> {
  UpdateCustomerUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<void> build(CustomerUpdateRequest input) {
    return _customerRepo.customerUpdate(input);
  }
}
