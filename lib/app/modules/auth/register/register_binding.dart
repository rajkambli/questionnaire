import 'package:get/get.dart';
import 'package:questionnaire/app/data/repositories/auth_repository.dart';
import 'package:questionnaire/app/modules/auth/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
