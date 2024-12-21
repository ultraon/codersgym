import 'package:codersgym/core/theme/app_theme.dart';
import 'package:codersgym/features/code_editor/presentation/widgets/code_successful_submission_dialog.dart';
import 'package:codersgym/features/question/domain/model/question.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuestionStatusIcon extends StatelessWidget {
  const QuestionStatusIcon({
    super.key,
    required this.status,
  });
  final QuestionStatus status;

  @override
  Widget build(BuildContext context) {
    return Icon(
      getStatusIcon(),
      color: getStatusColor(context),
    );
  }

  IconData? getStatusIcon() {
    return switch (status) {
      QuestionStatus.accepted => Icons.check_circle,
      QuestionStatus.notAccepted => Icons.incomplete_circle,
      _ => null,
    };
  }

  Color getStatusColor(BuildContext context) {
    final theme = Theme.of(context);
    return switch (status) {
      QuestionStatus.accepted => theme.colorScheme.successColor,
      QuestionStatus.notAccepted => theme.primaryColor,
      _ => theme.hintColor,
    };
  }
}
