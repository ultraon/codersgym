import 'package:codersgym/features/profile/domain/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeetCodeStreakFire extends StatelessWidget {
  final StreakCounter streakCounter;

  const LeetCodeStreakFire({
    super.key,
    required this.streakCounter,
  });

  @override
  Widget build(BuildContext context) {
    final streakCount = streakCounter.streakCount;
    final theme = Theme.of(context);
    final streakColor = streakCounter.currentDayCompleted
        ? theme.primaryColor
        : theme.hintColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.fire,
          color: streakColor,
          size: 18,
        ),
        const SizedBox(width: 8.0),
        Text(
          '$streakCount',
          style: theme.textTheme.titleLarge?.copyWith(color: streakColor),
        ),
      ],
    );
  }
}
