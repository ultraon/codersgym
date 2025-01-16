import 'package:codersgym/features/profile/domain/model/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../profile/presentation/widgets/leetcode_streak_fire.dart';

class UserGreetingCard extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final StreakCounter? streak;

  const UserGreetingCard({
    super.key,
    required this.userName,
    required this.avatarUrl,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundImage:
              (avatarUrl.isNotEmpty) ? NetworkImage(avatarUrl) : null,
          // You can use AssetImage('assets/images/avatar.png') for a local image
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              userName,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            // Additional greeting message can be added here if needed
          ],
        ),
        const Spacer(),
        if (streak != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LeetCodeStreakFire(
              streakCounter: streak!,
            ),
          ),
      ],
    );
  }

  factory UserGreetingCard.loading() {
    return const UserGreetingCard(
      userName: "Coder",
      avatarUrl: "",
      streak: null,
    );
  }
}
