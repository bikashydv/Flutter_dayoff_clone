import 'package:flutter/material.dart';
import 'package:holiday/model/holiday_request_model.dart';
import 'package:holiday/provider/holiday%20_request_provider.dart';
import 'package:provider/provider.dart';

class HolidayRequestPage extends StatefulWidget {
  const HolidayRequestPage({required this.onchange});

  final Function(int) onchange;

  @override
  State<HolidayRequestPage> createState() => _RequestHolidayState();
}

class _RequestHolidayState extends State<HolidayRequestPage> {
  DateTime? startdate;
  DateTime? enddate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HolidayRequestProvider>(
          builder: (context, holidayRequestProvider, _child) {
        if (holidayRequestProvider.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: 30, left: 40),
          child: Column(
            children: [
              startdate == null
                  ? SizedBox()
                  : Container(
                      child: Text(
                        '${startdate!.year}:${startdate!.month}:${startdate!.day}',
                      ),
                    ),
              Container(
                child: TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2023),
                    );
                    if (picked != null) {
                      setState(() {
                        
                        if (enddate != null && picked.isAfter(enddate!)) {
                          enddate = null;
                        }
                        startdate = picked;
                      });
                    }
                    ;
                  },
                  child: Text('Start'),
                ),
              ),
              enddate == null
                  ? SizedBox()
                  : Container(
                      child: Text(
                        '${enddate!.year},${enddate!.month},${enddate!.day}',
                      ),
                    ),
              Container(
                child: TextButton(
                    onPressed: startdate == null
                        ? null
                        : () async {
                            ///to make end date always after start date
                            ///set first date to be always after start date
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: startdate!.add(Duration(days: 1)),
                              firstDate: startdate!.add(Duration(days: 1)),
                              lastDate: DateTime(2023),
                            );
                            if (picked != null) {
                              setState(() {
                                enddate = picked;
                              });
                            }
                            ;
                          },
                    child: Text('End')),
              ),
              Container(
                child: TextButton(
                    onPressed: () {
                      if (startdate != null && enddate != null) {
                        HolidayRequestModel holidayRequestModel =
                            HolidayRequestModel(
                          endtime: enddate!,
                          starttime: startdate!,
                          // status: false
                        );
                        Provider.of<HolidayRequestProvider>(context,
                                listen: false)
                            .requestHoliday(holidayRequestModel)
                            .then(
                          (value) {
                            if (value == true) {
                              final snackbar = SnackBar(
                                content: Text(
                                  'holiday requested successfully ',
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              widget.onchange(0);
                            } else {
                              final snackbar = SnackBar(
                                content: Text(
                                  'Error occerd',
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          },
                        );
                      } else {
                        print("please picke startdate and enddate");
                      }
                    },
                    child: Text('Request')),
              ),
            ],
          ),
        );
      },),
    );
  }
}
