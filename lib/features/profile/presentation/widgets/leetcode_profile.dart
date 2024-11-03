import 'package:dailycoder/core/api/api_state.dart';
import 'package:dailycoder/features/profile/domain/model/contest_ranking_info.dart';
import 'package:dailycoder/features/profile/presentation/blocs/contest_ranking_info/contest_ranking_info_cubit.dart';
import 'package:dailycoder/features/profile/presentation/widgets/badge_carousel.dart';
import 'package:dailycoder/features/profile/presentation/widgets/leetcode_rating_chart.dart';
import 'package:dailycoder/features/profile/presentation/widgets/submission_heat_map_calendart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../injection.dart';
import '../../domain/model/user_profile.dart';
import 'leetcode_user_profile_card.dart';

class LeetcodeProfile extends HookWidget {
  const LeetcodeProfile({
    super.key,
    required this.userProfile,
  });
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final contestRankingInfoCubit = getIt.get<ContestRankingInfoCubit>();
    useEffect(() {
      contestRankingInfoCubit.getContestRankingInfo(userProfile.username ?? '');
      return null;
    }, []);
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
              "Contest Ratings",
              style: textTheme.titleMedium?.copyWith(color: theme.hintColor),
            ),
          ),
          BlocBuilder<ContestRankingInfoCubit,
              ApiState<ContestRankingInfo, Exception>>(
            bloc: contestRankingInfoCubit,
            builder: (context, state) {
              return state.when(
                onInitial: () => Center(child: CircularProgressIndicator()),
                onLoading: () => Center(child: CircularProgressIndicator()),
                onLoaded: (contestRankingInfo) {
                  final dataPoints =
                      contestRankingInfo.userContestRankingHistory
                          ?.where(
                    (e) => e.attended ?? false,
                  )
                          .mapIndexed(
                    (i, e) {
                      return DataPoint(
                          i.toDouble() ?? 0, e.rating?.toInt().toDouble() ?? 0.0);
                    },
                  ).toList();
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: LeetcodeRatingChart(
                        dataPoints: dataPoints ?? [],
                      ),
                    ),
                  );
                },
                onError: (exception) => Text(exception.toString()),
              );
            },
          ),
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
