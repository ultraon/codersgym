import 'dart:math';

import 'package:collection/collection.dart';
import 'package:dailycoder/features/profile/domain/model/contest_ranking_info.dart';
import 'package:dailycoder/features/profile/presentation/widgets/leetcode_rating_chart.dart';
import 'package:dailycoder/features/profile/presentation/widgets/user_profile_info.dart';
import 'package:dailycoder/core/utils/number_extension.dart';
import 'package:flutter/material.dart';

class LeetcodeRatingDetails extends StatelessWidget {
  const LeetcodeRatingDetails({
    super.key,
    required this.contestRankingInfo,
  });
  final ContestRankingInfo contestRankingInfo;

  @override
  Widget build(BuildContext context) {
    final dataPoints = contestRankingInfo.userContestRankingHistory
        ?.where(
      (e) => e.attended ?? false,
    )
        .mapIndexed(
      (i, e) {
        return DataPoint(
          i.toDouble(),
          e.rating?.toInt().toDouble() ?? 0.0,
        );
      },
    ).toList();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            UserProfileInfo(
              title: "Global Ranking",
              data: contestRankingInfo.globalRanking?.toReadableNumber ?? "",
            ),
            UserProfileInfo(
              title: "Top Leetcode",
              data: "${contestRankingInfo.topPercentage}%",
            ),
            UserProfileInfo(
              title: "Attended",
              data: contestRankingInfo.attendedContestsCount.toString(),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        LeetcodeRatingChart(
          dataPoints: dataPoints ?? [],
        ),
      ],
    );
  }

  factory LeetcodeRatingDetails.empty() {
    final dummyRating = List.generate(
      10,
      (index) {
        // Use a cosine function to create a wave pattern for the rating.
        double amplitude = 100; // Controls the height of the wave
        double baseRating = 1400; // Base rating to oscillate around
        double frequency = 0.4; // Controls the wavelength

        return UserContestRankingHistory(
          rating:
              (baseRating + amplitude * cos(index * frequency * pi)).round(),
          attended: true,
        );
      },
    );
    return LeetcodeRatingDetails(
      contestRankingInfo: ContestRankingInfo(
        userContestRankingHistory: dummyRating,
      ),
    );
  }
}
