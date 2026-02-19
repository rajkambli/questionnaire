import 'package:get/get.dart';
import 'package:questionnaire/app/data/repositories/auth_repository.dart';
import 'package:questionnaire/app/modules/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
