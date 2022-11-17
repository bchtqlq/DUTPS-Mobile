import 'package:dut_packing_system/feature/customer/data/models/faculties_model.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';

import '../../../../base/domain/base_usecase.dart';

class GetFacultiesUsecase extends UseCase<List<FacultyModel>> {
  GetFacultiesUsecase(this._customerRepo);
  final CustomerRepo _customerRepo;

  @override
  Future<List<FacultyModel>> build() {
    return _customerRepo.getAllFaculty();
  }
}
