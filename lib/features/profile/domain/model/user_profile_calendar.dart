class UserProfileCalendar {
  final List<int>? activeYears;
  final int? streak;
  final int? totalActiveDays;
  final List<CalendarSubmission>? submissionCalendar;

  UserProfileCalendar({
    this.activeYears,
    this.streak,
    this.totalActiveDays,
    this.submissionCalendar,
  });
}

class CalendarSubmission {
  final int timeStamp;
  final int submissionCount;

  CalendarSubmission(this.timeStamp, this.submissionCount);
}
