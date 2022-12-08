import 'package:flutter/material.dart';
import 'package:holiday/screens/dashboard/dashboard_page/add_employee_page.dart';

class RequestAprovePage extends StatelessWidget {
  const RequestAprovePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 40,
          ),
          child: Container(
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEmployee()),
              );
            },
            child: Container(
              height: 40,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.blue),
              child: Text('Add Employee '),
            ),
          ),
        ),
      ]),
    );
  }
}
