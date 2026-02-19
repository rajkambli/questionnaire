import 'package:questionnaire/app/core/constants/api_constants.dart';
import 'package:questionnaire/app/data/models/questionnaire_model.dart';

import '../services/api_service.dart';

class QuestionnaireRepository {
  final ApiService _apiService = ApiService();

  Future<List<QuestionnaireModel>> getAllQuestionnaires() async {
    final response = await _apiService.get(ApiConstants.questionnaires);
    final List<dynamic> data = response.data;
    return data.map((json) => QuestionnaireModel.fromJson(json)).toList();
  }
}
