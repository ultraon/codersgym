class ContestRankingInfo {
  final int? attendedContestsCount;
  final double? rating;
  final int? globalRanking;
  final int? totalParticipants;
  final double? topPercentage;
  final List<UserContestRankingHistory>? userContestRankingHistory;

  ContestRankingInfo({
    this.attendedContestsCount,
    this.rating,
    this.globalRanking,
    this.totalParticipants,
    this.topPercentage,
    this.userContestRankingHistory,
  });
}

class UserContestRankingHistory {
  final bool? attended;
  final String? trendDirection;
  final int? problemsSolved;
  final int? totalProblems;
  final num? rating;
  final int? ranking;
  final Contest? contest;

  UserContestRankingHistory({
    this.attended,
    this.trendDirection,
    this.problemsSolved,
    this.totalProblems,
    this.rating,
    this.ranking,
    this.contest,
  });
}

class Contest {
  final String? title;
  final int? startTime;

  Contest(this.title, this.startTime);
}
