import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:questionnaire/app/data/models/question_model.dart';
import 'package:questionnaire/app/data/models/questionnaire_model.dart';
import 'package:questionnaire/app/data/models/submission_model.dart';
import 'package:questionnaire/app/data/services/local_storage_service.dart';
import 'package:questionnaire/app/data/services/location_service.dart';
import 'package:intl/intl.dart';

class QuestionnaireController extends GetxController {
  late final QuestionnaireModel questionnaire;
  final questions = <QuestionModel>[].obs;
  final selectedAnswers = <String, String>{}.obs;
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    questionnaire = Get.arguments as QuestionnaireModel;
    _loadQuestions();
  }

  void _loadQuestions() {
    questions.assignAll([
      QuestionModel(
        id: 'q1',
        questionText: 'How satisfied are you with this questionnaire topic?',
        options: ['Very Satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
      ),
      QuestionModel(
        id: 'q2',
        questionText: 'How often do you engage with similar content?',
        options: ['Daily', 'Weekly', 'Monthly', 'Rarely'],
      ),
      QuestionModel(
        id: 'q3',
        questionText: 'Would you recommend this to others?',
        options: ['Definitely', 'Probably', 'Not Sure', 'No'],
      ),
      QuestionModel(
        id: 'q4',
        questionText: 'How do you rate the difficulty level?',
        options: ['Easy', 'Moderate', 'Hard'],
      ),
      QuestionModel(
        id: 'q5',
        questionText: 'What is your overall experience?',
        options: ['Excellent', 'Good', 'Average', 'Poor'],
      ),
    ]);
  }

  void selectAnswer(String questionId, String answer) {
    selectedAnswers[questionId] = answer;
  }

  bool get allAnswered => selectedAnswers.length == questions.length;

  Future<bool> submitAnswers() async {
    if (LocalStorageService.isQuestionnaireSubmitted(questionnaire.id ?? '')) {
      Get.snackbar(
        'Already Submitted',
        'You have already submitted this questionnaire.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return false;
    }

    if (!allAnswered) {
      Get.snackbar(
        'Incomplete',
        'Please answer all questions before submitting.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return false;
    }

    isSubmitting.value = true;
    try {
      double lat = 0.0;
      double lng = 0.0;

      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        lat = position.latitude;
        lng = position.longitude;
      }

      final submission = SubmissionModel(
        questionnaireId: questionnaire.id ?? '',
        questionnaireTitle: questionnaire.title ?? 'Untitled',
        answers: Map<String, String>.from(selectedAnswers),
        submittedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        latitude: lat,
        longitude: lng,
      );

      await LocalStorageService.saveSubmission(submission);
      return true;
    } catch (e) {
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }
}
