import 'package:get/get.dart';
import 'package:questionnaire/app/data/repositories/questionnaire_repository.dart';
import 'package:questionnaire/app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionnaireRepository>(() => QuestionnaireRepository());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
