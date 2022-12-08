import 'package:flutter/material.dart';
import 'package:holiday/model/holiday_request_model.dart';
import 'package:holiday/provider/holiday%20_request_provider.dart';
import 'package:holiday/screens/dashboard/dashboard_page/calender/holiday.dart';
import 'package:holiday/screens/dashboard/dashboard_page/calender/holiday_data_source.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

dateformate(DateTime d) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(d);

  return formattedDate;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Holiday> _getDataSource(List<HolidayRequestModel> holiday) {
    final List<Holiday> meetings = <Holiday>[];
    holidays.forEach((element) {
      final DateTime today = element.starttime!;
      final DateTime StartTime =
          DateTime(today.year, today.month, today.day, 9, 0, 0);
      final DateTime endTime = element.endtime!;
      meetings
          .add(Holiday('ayush', StartTime, endTime, Color(0xFF0f8644), false));
    });

    return meetings;
  }

  List<HolidayRequestModel> holidays = [];
  @override
  void initState() {
    super.initState();
    getHolidaysData();
  }

  void getHolidaysData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HolidayRequestProvider>(context, listen: false)
          .getRequestedHolidays()
          .then((value) {
        setState(() {
          holidays = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
        ),
        child: Column(
          children: [
            Container(
              height: 500,
              width: 400,
              child: SfCalendar(
                view: CalendarView.month,
                dataSource: HolidayDataSource(_getDataSource(holidays)),
                monthViewSettings: MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.indicator,
                    showAgenda: true),
              ),
            ),
            Expanded(
              child: holidays.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: holidays.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(
                                        dateformate(holidays[index].starttime!),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                        )),
                                  ),
                                  Container(
                                    child: Text(
                                        dateformate(holidays[index].endtime!),
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black54,
                                        )),
                                  ),
                                  Container(
                                    child: Text(
                                      daysBetween(holidays[index].starttime!,
                                              holidays[index].endtime!)
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    )
                  : SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
