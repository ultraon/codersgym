import 'package:dailycoder/core/utils/date_time_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class SubmissionHeatMapCalendar extends StatelessWidget {
  const SubmissionHeatMapCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      defaultColor: Theme.of(context).canvasColor,
      colorMode: ColorMode.color,
      margin: const EdgeInsets.all(2),
      scrollable: true,
      startDate: DateTime.now().subtract(Duration(days: 90)).onlyDate,
      size: 18,
      datasets: {
        DateTime.now().onlyDate: 1,
        DateTime.now().subtract(Duration(days: 1)).onlyDate: 1,
        DateTime.now().subtract(Duration(days: 2)).onlyDate: 2,
        DateTime.now().subtract(Duration(days: 3)).onlyDate: 1,
        DateTime.now().subtract(Duration(days: 4)).onlyDate: 3,
        DateTime.now().subtract(Duration(days: 5)).onlyDate: 4,
        DateTime.now().subtract(Duration(days: 6)).onlyDate: 1,
        DateTime.now().subtract(Duration(days: 7)).onlyDate: 2,
        DateTime.now().subtract(Duration(days: 8)).onlyDate: 4,
        DateTime.now().subtract(Duration(days: 9)).onlyDate: 5,
        DateTime.now().subtract(Duration(days: 10)).onlyDate: 1,
        DateTime.now().subtract(Duration(days: 11)).onlyDate: 2,
        DateTime.now().subtract(Duration(days: 12)).onlyDate: 3,
        DateTime.now().subtract(Duration(days: 13)).onlyDate: 1,
        DateTime.now().subtract(Duration(days: 14)).onlyDate: 2,
        DateTime.now().subtract(Duration(days: 15)).onlyDate: 3,
        DateTime.now().subtract(Duration(days: 16)).onlyDate: 4,
        DateTime.now().subtract(Duration(days: 17)).onlyDate: 1,
        DateTime.now().subtract(Duration(days: 18)).onlyDate: 2,
        DateTime.now().subtract(Duration(days: 19)).onlyDate: 3,
        DateTime.now().subtract(Duration(days: 20)).onlyDate: 4,
        DateTime.now().subtract(Duration(days: 21)).onlyDate: 1,
        DateTime.now().subtract(Duration(days: 22)).onlyDate: 2,
      },
      colorsets: const {
        1: Color(0xff026421),
        2: Color(0xff28C245),
        3: Color(0xff7EE08A),
      },
    );
  }
}
