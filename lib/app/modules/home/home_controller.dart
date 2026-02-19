import 'package:get/get.dart';
import 'package:questionnaire/app/data/models/questionnaire_model.dart';
import 'package:questionnaire/app/data/repositories/questionnaire_repository.dart';

class HomeController extends GetxController {
  final QuestionnaireRepository _questionnaireRepository = QuestionnaireRepository();

  final questionnaires = <QuestionnaireModel>[].obs;
  final isLoading = false.obs;
  final currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestionnaires();
  }

  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  Future<void> fetchQuestionnaires() async {
    isLoading.value = true;
    try {
      final result = await _questionnaireRepository.getAllQuestionnaires();
      questionnaires.assignAll(result);
    } catch (e) {
      questionnaires.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
