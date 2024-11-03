import 'package:dailycoder/features/profile/presentation/widgets/badge_carousel.dart';
import 'package:dailycoder/features/profile/presentation/widgets/submission_heat_map_calendart.dart';
import 'package:flutter/material.dart';

import '../../domain/model/user_profile.dart';
import 'leetcode_user_profile_card.dart';

class LeetcodeProfile extends StatelessWidget {
  const LeetcodeProfile({
    super.key,
    required this.userProfile,
  });
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LeetcodeUserProfileCard(
              userProfile: userProfile,
            ),
          ),
          const SizedBox(height: 16),
          if (userProfile.badges?.isNotEmpty ?? false) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Badges : ",
                    style:
                        textTheme.titleMedium?.copyWith(color: theme.hintColor),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    userProfile.badges!.length.toString(),
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 2),
            BadgeCarousel(
              badges: userProfile.badges!,
            ),
          ],
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Submission",
              style: textTheme.titleMedium?.copyWith(color: theme.hintColor),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SubmissionHeatMapCalendar(),
          ),
        ],
      ),
    );
  }
}
