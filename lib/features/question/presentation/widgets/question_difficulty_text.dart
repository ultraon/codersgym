import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dailycoder/features/question/domain/model/question.dart';

class QuestionDifficultyText extends HookWidget {
  const QuestionDifficultyText(
    this.question, {
    super.key,
  });
  final Question question;

  @override
  Widget build(BuildContext context) {
    final isDifficultyVisible = useState(false);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Row(
      children: [
        Text(
          "Difficulty: \t",
          style: textTheme.bodyMedium?.copyWith(color: theme.hintColor),
        ),
        SizedBox(
          width: 60, // Prevents reposition of visibility icon
          child: (isDifficultyVisible.value)
              ?
              // Difficulty value shown with appropriate color
              Text(
                  question.difficulty ?? "N/A",
                  style: textTheme.bodyMedium?.copyWith(
                    color: getColorFromDifficulty(
                        question.difficulty ?? "Unknown"),
                  ),
                )
              :
              // Hidden difficulty represented by dots
              Text(
                  "•••••••",
                  style: textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                ),
        ),
        IconButton(
          icon: Icon(
            isDifficultyVisible.value ? Icons.visibility_off : Icons.visibility,
            color: theme.hintColor,
          ),
          onPressed: () {
            isDifficultyVisible.value = !isDifficultyVisible.value;
          },
        ),
      ],
    );
  }
}

getColorFromDifficulty(String difficulty) {
  return switch (difficulty) {
    "Easy" => Colors.green,
    "Medium" => Colors.amber,
    "Hard" => Colors.red,
    _ => Colors.grey,
  };
}
