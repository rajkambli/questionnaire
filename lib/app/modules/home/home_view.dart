import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire/app/core/theme/app_theme.dart';
import 'package:questionnaire/app/data/models/questionnaire_model.dart';
import 'package:questionnaire/app/data/services/local_storage_service.dart';
import 'package:questionnaire/app/modules/home/home_controller.dart';
import 'package:questionnaire/app/modules/profile/profile_view.dart';
import 'package:questionnaire/app/routes/app_routes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentTabIndex.value) {
          case 0:
            return _buildQuestionnairesTab();
          case 1:
            return const ProfileView();
          default:
            return _buildQuestionnairesTab();
        }
      }),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentTabIndex.value,
            onTap: controller.changeTab,
            backgroundColor: Colors.white,
            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: AppTheme.textSecondary,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.quiz_outlined),
                activeIcon: Icon(Icons.quiz_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionnairesTab() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaires'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppTheme.primaryColor),
          );
        }

        if (controller.questionnaires.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.quiz_outlined,
                  size: 80,
                  color: AppTheme.textSecondary.withValues(alpha: 0.4),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No questionnaires found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pull down to refresh',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: AppTheme.primaryColor,
          onRefresh: controller.fetchQuestionnaires,
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.questionnaires.length,
            itemBuilder: (context, index) {
              return _buildQuestionnaireCard(controller.questionnaires[index], index);
            },
          ),
        );
      }),
    );
  }

  Widget _buildQuestionnaireCard(QuestionnaireModel questionnaire, int index) {
    final colors = [
      const Color(0xFF6C63FF),
      const Color(0xFF03DAC6),
      const Color(0xFFFF6584),
      const Color(0xFFFFB74D),
      const Color(0xFF4FC3F7),
    ];

    final accentColor = colors[index % colors.length];
    final isCompleted = LocalStorageService.isQuestionnaireSubmitted(questionnaire.id ?? '');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          if (isCompleted) {
            Get.snackbar(
              'Already Submitted',
              'You have already completed this questionnaire.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange.shade400,
              colorText: Colors.white,
              margin: const EdgeInsets.all(16),
              borderRadius: 12,
            );
            return;
          }
          Get.toNamed(
            AppRoutes.questionnaire,
            arguments: questionnaire,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withValues(alpha: 0.12)
                      : accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check_rounded, color: Colors.green, size: 24)
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            questionnaire.title ?? 'Untitled',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isCompleted) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Completed',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      questionnaire.description ?? '',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.textSecondary,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isCompleted ? Icons.check_circle_rounded : Icons.arrow_forward_ios_rounded,
                size: 16,
                color: isCompleted ? Colors.green : AppTheme.textSecondary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
