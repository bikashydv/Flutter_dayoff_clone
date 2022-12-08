import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:holiday/local_data_source/user_local_data_source.dart';
import 'package:holiday/provider/auth_provider.dart';
import 'package:holiday/screens/dashboard/navigationbar_page.dart';
import 'package:provider/provider.dart';

import '../../dashboard/dashboard_page/home_page.dart';

class UserLogin extends StatefulWidget {
  final bool isCompany;
  UserLogin({super.key, required this.isCompany});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _emailController =
      TextEditingController(text: 'bikash@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 20, left: 10),
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Login to you account',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'USERNAME',
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
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
                Container(
                  child: ElevatedButton(
                    onPressed: () async{
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        if (widget.isCompany == true) {
                          Provider.of<AuthProvider>(context, listen: false)
                              .signInWithEmailAndPassword(_emailController.text,
                                  _passwordController.text, context)
                              .then((value) async{
                            if (value == true) {
                              String employeeId =
                                  await UserLocalDataSource.getEmployeeyId();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashboardPage(employeeId: employeeId,),
                                  ), (route) {
                                return false;
                              });
                            }
                          });
                        } else {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logInUserOfTheCompany(
                            _emailController.text,
                            _passwordController.text,
                          )
                              .then((value)async {
                            if (value) {
                              String employeeId =
                                  await UserLocalDataSource.getEmployeeyId();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashboardPage(employeeId: employeeId,),
                                  ),
                                  (route) => false);
                            } else {
                              final snackbar = SnackBar(
                                  content: Text(
                                      "Email or password you entered, didnot match"));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          });
                        }
                      } else {
                        final snackbar = SnackBar(
                          content: Text('email and password is require'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ),
                  ),
                )
              ],
            ),
          ),
          Provider.of<AuthProvider>(context).isLoading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

// class CompanyLogin extends StatefulWidget {
//   const CompanyLogin({super.key});

//   @override
//   State<CompanyLogin> createState() => _CompanyLoginState();
// }

// class _CompanyLoginState extends State<CompanyLogin> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
