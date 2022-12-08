import 'package:flutter/material.dart';
import 'package:holiday/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class CompanyAccountPage extends StatefulWidget {
  const CompanyAccountPage({super.key});

  @override
  State<CompanyAccountPage> createState() => _CompanyAccountPageState();
}

class _CompanyAccountPageState extends State<CompanyAccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companynameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stack(
            //   alignment: Alignment.bottomRight,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 15, top: 50),
            //       child: Container(
            //         child: CircleAvatar(
            //           backgroundImage: AssetImage('assests/login/image1.png'),
            //           radius: 100,
            //         ),
            //       ),
            //     ),
            //     InkWell(
            //       child: Padding(
            //         padding: const EdgeInsets.only(right: 15, bottom: 20),
            //         child: Icon(Icons.edit),
            //       ),
            //     )
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'EMAIL ',
                      ),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: 'address',
                        labelText: 'ADDRESS',
                      ),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _companynameController,
                      decoration: InputDecoration(
                        hintText: 'Company Name',
                        labelText: 'COMPANY_NAME',
                      ),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _passwordController,
                      // obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter your password',
                          labelText: 'Password'.toUpperCase(),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: Colors.black38,
                          )),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      // obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'confirm your password',
                          labelText: 'confirm Password'.toUpperCase(),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: Colors.black38,
                          )),
                    ),
                  ),
                  Container(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        labelText: 'PHONE NUUMBER',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        print('triggred');
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _confirmPasswordController.text.isNotEmpty) {
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            print('printed');
                            Provider.of<AuthProvider>(context, listen: false)
                                .signUpWithEmailAndPassword(
                                    _emailController.text,
                                    _passwordController.text,
                                    _addressController.text,
                                    _phoneController.text,
                                    _companynameController.text,
                                    context);
                          } else {
                            final Snackbar = SnackBar(
                                content: Text('password did not match'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(Snackbar);
                          }
                        }
                      },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
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
      ),
    );
  }
}

 // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DashboardPage()));