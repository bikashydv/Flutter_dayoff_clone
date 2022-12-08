import 'package:flutter/material.dart';
import 'package:holiday/model/employee_model.dart';
import 'package:holiday/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _employeName = TextEditingController();
  final TextEditingController _employeEmail = TextEditingController();
  final TextEditingController _employeNumber = TextEditingController();
  final TextEditingController _employePassword = TextEditingController();
  final TextEditingController _employeAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: _employeName,
                decoration: InputDecoration(
                  hintText: 'Enter employe Name',
                  labelText: 'Employe Name'.toUpperCase(),
                ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _employeEmail,
                decoration: InputDecoration(
                  hintText: 'Enter employe email',
                  labelText: 'employe email'.toUpperCase(),
                ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _employeNumber,
                decoration: InputDecoration(
                  hintText: 'Enter employe number',
                  labelText: 'employe number'.toUpperCase(),
                ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _employeAddress,
                decoration: InputDecoration(
                  hintText: 'Enter employe address',
                  labelText: 'employe address'.toUpperCase(),
                ),
              ),
            ),
            Container(
              child: TextFormField(
                // obscureText: true,
                controller: _employePassword,
                decoration: InputDecoration(
                    hintText: 'Enter employe password',
                    labelText: 'Password'.toUpperCase(),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.black38,
                    )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                if (_employeAddress.text.isNotEmpty &&
                    _employeEmail.text.isNotEmpty &&
                    _employeName.text.isNotEmpty &&
                    _employeNumber.text.isNotEmpty &&
                    _employePassword.text.isNotEmpty) {
                  EmployeeModel employee = EmployeeModel(
                      name: _employeName.text,
                      email: _employeEmail.text,
                      phoneNumber: _employeNumber.text,
                      password: _employePassword.text,
                      address: _employeAddress.text);
                  Provider.of<AuthProvider>(context, listen: false)
                      .addEmployeeOfCompany(employee, context);
                  print('requested');
                } else {
                  final snackBar =
                      SnackBar(content: Text("Please fill the form"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(
                height: 40,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue),
                child: Text('create '),
              ),
            )
          ],
        ),
      ),
    );
  }
}
