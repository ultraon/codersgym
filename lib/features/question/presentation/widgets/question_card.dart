import 'package:codersgym/features/question/presentation/widgets/question_status_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:codersgym/features/question/domain/model/question.dart';
import 'package:codersgym/features/question/presentation/widgets/question_difficulty_text.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
    required this.onTap,
    this.backgroundColor,
  });

  final Question question;
  final VoidCallback onTap;
  final Color? backgroundColor;

  factory QuestionCard.empty() {
    return QuestionCard(
      question: const Question(),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Card(
      elevation: 4,
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      ("${question.frontendQuestionId}. ") +
                          (question.title ?? "No Title"),
                      style: textTheme.titleMedium,
                    ),
                  ),
                  if (question.status != null)
                    QuestionStatusIcon(
                      status: question.status!,
                    ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuestionDifficultyText(question),
                  Row(
                    children: [
                      Text("Acceptance: "),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${question.acRate?.toStringAsFixed(2) ?? ""}%",
                        style: textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
