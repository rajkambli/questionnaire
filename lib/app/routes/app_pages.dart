import 'package:get/get.dart';
import 'package:questionnaire/app/modules/auth/login/login_binding.dart';
import 'package:questionnaire/app/modules/auth/login/login_view.dart';
import 'package:questionnaire/app/modules/auth/register/register_binding.dart';
import 'package:questionnaire/app/modules/auth/register/register_view.dart';
import 'package:questionnaire/app/modules/home/home_binding.dart';
import 'package:questionnaire/app/modules/home/home_view.dart';
import 'package:questionnaire/app/modules/questionnaire/questionnaire_binding.dart';
import 'package:questionnaire/app/modules/questionnaire/questionnaire_view.dart';
import 'package:questionnaire/app/modules/profile/submission_history_view.dart';
import 'package:questionnaire/app/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.questionnaire,
      page: () => const QuestionnaireView(),
      binding: QuestionnaireBinding(),
    ),
    GetPage(
      name: AppRoutes.submissionHistory,
      page: () => const SubmissionHistoryView(),
    ),
  ];
}
