import 'package:dut_packing_system/feature/customer/data/models/customer_model.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetCustomerInfoUsecase extends UseCase<CustomerModel> {
  GetCustomerInfoUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<CustomerModel> build() {
    return _customerRepo.customerInfo();
  }
}
