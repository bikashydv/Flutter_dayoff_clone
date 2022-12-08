import 'package:flutter/material.dart';
import 'package:holiday/model/holiday_request_model.dart';
import 'package:holiday/screens/dashboard/dashboard_page/holiday_request_page.dart';
import 'package:holiday/screens/dashboard/dashboard_page/home_page.dart';
import 'package:holiday/utils/enums.dart';
import 'package:provider/provider.dart';

import '../../../provider/holiday _request_provider.dart';

class RequestPage extends StatefulWidget {
  const RequestPage(
      {required this.employeeId, required Null Function(dynamic p0) onchange});

  final String employeeId;
  @override
  _RequestPage createState() => _RequestPage();
}

class _RequestPage extends State<RequestPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HolidayRequestProvider>(context, listen: false)
          .getPendingHoliday();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      16.0,
                    ),
                    color: Colors.grey.shade900,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey.shade900,
                  tabs: [
                    Tab(
                      text: 'Request',
                    ),
                    Tab(
                      text: 'Balance',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Stack(
                      children: [
                        Provider.of<HolidayRequestProvider>(
                          context,
                        ).pendingHolidas.isEmpty
                            ? Container(
                                child: Text(
                                  'No Pending Vacation Requests',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: Provider.of<HolidayRequestProvider>(
                                        context,
                                        listen: false)
                                    .pendingHolidas
                                    .length,
                                itemBuilder: (ctx, index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  'Name',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  Provider.of<HolidayRequestProvider>(
                                                          context,
                                                          listen: false)
                                                      .pendingHolidas[index]
                                                      .starttime
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                    Provider.of<HolidayRequestProvider>(
                                                            context,
                                                            listen: false)
                                                        .pendingHolidas[index]
                                                        .endtime
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300)),
                                              ),
                                              Container(
                                                child: Text(
                                                    daysBetween(
                                                            Provider.of<HolidayRequestProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .pendingHolidas[
                                                                    index]
                                                                .starttime!,
                                                            Provider.of<HolidayRequestProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .pendingHolidas[
                                                                    index]
                                                                .endtime!)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.red)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      widget.employeeId == ""
                                          ? InkWell(
                                              onTap: () {
                                                Provider.of<HolidayRequestProvider>(
                                                        context,
                                                        listen: false)
                                                    .updateHolidayStatus(
                                                        Provider.of<HolidayRequestProvider>(
                                                                context,
                                                                listen: false)
                                                            .pendingHolidas[
                                                                index]
                                                            .holidayId!,
                                                        HolidayStatus.ACCEPTED);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Colors.blue),
                                                child: Icon(Icons.check),
                                              ),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      widget.employeeId == ""
                                          ? InkWell(
                                              onTap: () {
                                                Provider.of<HolidayRequestProvider>(
                                                        context,
                                                        listen: false)
                                                    .updateHolidayStatus(
                                                        Provider.of<HolidayRequestProvider>(
                                                                context,
                                                                listen: false)
                                                            .pendingHolidas[
                                                                index]
                                                            .holidayId!,
                                                        HolidayStatus.REJECTED);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Colors.blueGrey),
                                                child: Icon(Icons.close),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  );
                                },
                              ),
                        Provider.of<HolidayRequestProvider>(context).isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox()
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            child: Text(
                              'pending'.toUpperCase(),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HolidayRequestPage(
                          onchange: (int) {},
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                    child: Text('Holiday Request '),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
