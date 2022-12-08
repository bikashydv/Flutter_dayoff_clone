import 'package:flutter/rendering.dart';
import 'package:holiday/screens/dashboard/dashboard_page/calender/holiday.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HolidayDataSource extends CalendarDataSource {
  HolidayDataSource(List<Holiday> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  // @override
  // String getSubject(int index) {
  //   return appointments![index].Name;
  // }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isDay;
  }
}
