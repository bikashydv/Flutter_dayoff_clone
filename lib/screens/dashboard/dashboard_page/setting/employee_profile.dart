import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:holiday/model/company_model.dart';
import 'package:holiday/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class EmployeeProfile extends StatefulWidget {
  const EmployeeProfile({super.key});

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 10),
              child: Container(
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 105,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage("assests/login/avtar.png"),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.white70,
                    ),
                    color: Colors.blue),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildTextField("Employee Email", 'bas'),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildTextField(
            "Employee Name",
            ".name",
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 40,
              width: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blueGrey),
              child: Text('SAVE CHANGES'),
            ),
          ),
        ),
      ]),
    );
  }
}

Widget buildTextField(String labelText, String placeholder) {
  return TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 5),
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
  );
}
