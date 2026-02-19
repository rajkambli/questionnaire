import 'package:flutter/material.dart';
import 'package:questionnaire/app/core/theme/app_theme.dart';
import 'package:questionnaire/app/data/models/submission_model.dart';
import 'package:questionnaire/app/data/services/local_storage_service.dart';

class SubmissionHistoryView extends StatelessWidget {
  const SubmissionHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final submissions = LocalStorageService.getAllSubmissions().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Submission History (${submissions.length})',
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: submissions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 64,
                    color: AppTheme.textSecondary.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No submissions yet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: submissions.length,
              itemBuilder: (context, index) {
                return _buildSubmissionCard(submissions[index], index);
              },
            ),
    );
  }

  Widget _buildSubmissionCard(SubmissionModel submission, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  submission.questionnaireTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppTheme.dividerColor),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: AppTheme.textSecondary.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 6),
              Text(
                submission.submittedAt,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppTheme.textSecondary.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 6),
              Text(
                submission.latitude == 0.0 && submission.longitude == 0.0
                    ? 'Location not available'
                    : '${submission.latitude.toStringAsFixed(4)}, ${submission.longitude.toStringAsFixed(4)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
