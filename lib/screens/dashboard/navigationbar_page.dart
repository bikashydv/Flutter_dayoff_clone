import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:holiday/local_data_source/user_local_data_source.dart';
import 'package:holiday/screens/dashboard/dashboard_page/home_page.dart';
import 'package:holiday/screens/dashboard/dashboard_page/request%20_aprove_page.dart';
import 'package:holiday/screens/dashboard/dashboard_page/pending_request_page.dart';
import 'package:holiday/screens/dashboard/dashboard_page/setting/setting.dart';
import 'package:holiday/screens/dashboard/dashboard_page/setting/setting_with_profile.dart';

class DashboardPage extends StatefulWidget {
  final String employeeId;
  const DashboardPage({required this.employeeId, super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentPage = 0;
  late List pages;
  late List<BottomNavigationBarItem> bottomNavBarItems;

  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(),
      RequestPage(
        employeeId: widget.employeeId,
        onchange: (p0) {
          setState(() {
            currentPage = p0;
          });
        },
      ),
    ];
    print('widget.employeeId ${widget.employeeId} ');
    widget.employeeId == "" ? pages.add(RequestAprovePage()) : null;
    pages.add(SettingPage());
  }

  List<BottomNavigationBarItem> bottomNavItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
          log(currentPage.toString());
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: currentPage == 0 ? Colors.green : Colors.grey,
            ),
            label: "",
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.watch_later,
              color: currentPage == 1 ? Colors.green : Colors.grey,
            ),
            label: "",
            // backgroundColor: Colors.blue,
          ),
          if (widget.employeeId == "")
            BottomNavigationBarItem(
              icon: Icon(
                Icons.groups,
                color: currentPage == 2 ? Colors.green : Colors.grey,
              ),
              label: "",
              // backgroundColor: Colors.blue,
            ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: widget.employeeId == ""
                  ? currentPage == 3
                      ? Colors.green
                      : Colors.grey
                  : currentPage == 2
                      ? Colors.green
                      : Colors.grey,
            ),
            label: "",
            // backgroundColor: Colors.blue,
          ),
        ],
      ),
      body: pages[currentPage],
    );
  }
}
