import 'package:dut_packing_system/feature/customer/data/models/list_history_model.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetHistoryUsecase extends UseCaseIO<String, ListHistoryModel> {
  GetHistoryUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<ListHistoryModel> build(String input) {
    return _customerRepo.getHistory(input);
  }
}
