import 'package:flutter/material.dart';
import 'package:holiday/local_data_source/user_local_data_source.dart';
import 'package:holiday/model/employee_model.dart';
import 'package:holiday/provider/auth_provider.dart';
import 'package:holiday/screens/dashboard/dashboard_page/setting/company_profile.dart';
import 'package:holiday/screens/dashboard/dashboard_page/setting/employee_profile.dart';
import 'package:holiday/screens/logins/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: TextButton.icon(
                label: Text('Working Day'),
                icon: Icon(Icons.run_circle_rounded),
                onPressed: () {
                  print('Pressed');
                },
              ),
            ),
            Divider(
              color: Colors.black12,
              indent: 40,
              endIndent: 40,
              height: 1,
              thickness: 2,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: TextButton.icon(
                  label: Text('Company Profile '),
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CompanyProfile()),
                    );
                    print('Pressed');
                  }),
            ),
            Divider(
              color: Colors.black12,
              indent: 40,
              endIndent: 40,
              height: 1,
              thickness: 2,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: TextButton.icon(
                label: Text(' Employee Profile'),
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmployeeProfile()),
                  );
                  print('Pressed');
                },
              ),
            ),
            Divider(
              color: Colors.black12,
              indent: 40,
              endIndent: 40,
              height: 1,
              thickness: 2,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: TextButton.icon(
                label: Text('Change Password'),
                icon: Icon(Icons.password),
                onPressed: () {
                  print('Pressed');
                },
              ),
            ),
            Divider(
              color: Colors.black12,
              indent: 40,
              endIndent: 40,
              height: 1,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10, bottom: 30),
              child: GestureDetector(
                onTap: () {
                  UserLocalDataSource.clearAllUserData().then(
                    (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginFirstPage()),
                        (route) => false),
                  );
                },
                child: Container(
                  height: 40,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Text('Log Out '),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
