import 'package:get/get.dart';
import 'package:questionnaire/app/modules/questionnaire/questionnaire_controller.dart';

class QuestionnaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionnaireController>(() => QuestionnaireController());
  }
}
