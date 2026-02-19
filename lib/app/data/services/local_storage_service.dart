import 'package:hive_flutter/hive_flutter.dart';
import 'package:questionnaire/app/data/models/submission_model.dart';

class LocalStorageService {
  static const String _userBoxName = 'user_box';
  static const String _submissionBoxName = 'submission_box';
  static const String _userKey = 'logged_in_user';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SubmissionModelAdapter());
    await Hive.openBox(_userBoxName);
    await Hive.openBox<SubmissionModel>(_submissionBoxName);
  }

  static Box get _userBox => Hive.box(_userBoxName);
  static Box<SubmissionModel> get _submissionBox => Hive.box<SubmissionModel>(_submissionBoxName);

  static Future<void> saveUser(Map<String, dynamic> userData) async {
    await _userBox.put(_userKey, userData);
  }

  static Map<String, dynamic>? getUser() {
    final data = _userBox.get(_userKey);
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }

  static bool isLoggedIn() {
    return _userBox.containsKey(_userKey);
  }

  static Future<void> clearUser() async {
    await _userBox.delete(_userKey);
  }

  static Future<void> saveSubmission(SubmissionModel submission) async {
    await _submissionBox.add(submission);
  }

  static bool isQuestionnaireSubmitted(String questionnaireId) {
    return _submissionBox.values.any((s) => s.questionnaireId == questionnaireId);
  }

  static List<SubmissionModel> getAllSubmissions() {
    return _submissionBox.values.toList();
  }

  static int getSubmissionCount() {
    return _submissionBox.length;
  }

  static Future<void> clearAll() async {
    await _userBox.clear();
  }
}
