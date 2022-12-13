import 'package:dio/dio.dart';
import 'package:dut_packing_system/feature/customer/data/providers/remote/customer_api.dart';
import 'package:dut_packing_system/feature/customer/data/repositories_imp/customer_repo_impl.dart';
import 'package:dut_packing_system/feature/customer/domain/repositoties/customer_repo.dart';
import 'package:dut_packing_system/feature/staff/data/providers/remote/staff_api.dart';
import 'package:dut_packing_system/feature/staff/data/repositories_imp/staff_repo_impl.dart';
import 'package:dut_packing_system/feature/staff/domain/repositoties/staff_repo.dart';
import 'package:get/instance_manager.dart';

import '../../../feature/authentication/data/repositories_imp/user_repo_impl.dart';
import '../../../feature/authentication/domain/repositoties/user_repo.dart';
import '../../base/data/remote/builder/dio_builder.dart';
import '../../feature/authentication/data/providers/remote/auth_api.dart';
import '../../feature/authentication/data/providers/remote/user_api.dart';
import '../../feature/authentication/data/repositories_imp/auth_repo_impl.dart';
import '../../feature/authentication/domain/repositoties/auth_repo.dart';
import '../services/storage_service.dart';
import '../services/storage_service_impl.dart';
import 'app_config.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    injectNetworkProvider();
    injectRepository();
    injectService();
  }

  void injectNetworkProvider() {
    Get.lazyPut(
      () => DioBuilder(
        options: BaseOptions(baseUrl: AppConfig.baseUrl),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => UserAPI(Get.find<DioBuilder>()),
      fenix: true,
    );
    Get.lazyPut(
      () => AuthAPI(Get.find<DioBuilder>()),
      fenix: true,
    );
    Get.lazyPut(
      () => CustomerAPI(Get.find<DioBuilder>()),
      fenix: true,
    );
    Get.lazyPut(
      () => StaffAPI(Get.find<DioBuilder>()),
      fenix: true,
    );
  }

  void injectRepository() {
    Get.put<UserRepo>(UserRepoImpl());
    Get.put<AuthRepo>(AuthRepoImpl());
    Get.put<CustomerRepo>(CustomerRepoImpl());
    Get.put<StaffRepo>(StaffRepoImpl());
  }

  void injectService() {
    Get.put<StorageService>(StorageServiceImpl());
  }
}
