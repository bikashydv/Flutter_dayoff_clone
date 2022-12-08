import 'package:flutter/material.dart';
import 'package:holiday/screens/logins/sign_up/createcompany.dart';
import 'package:holiday/screens/logins/sign_in/login_as_user.dart';

class LoginFirstPage extends StatelessWidget {
  const LoginFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 10),
            child: Container(
              child: Text(
                'Fell free to use',
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Container(
              child: Image.asset('assests/login/image1.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
              child: Image.asset('assests/login/pngwing.com.png'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(50, 0, 40, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(
                        child: const Text('Login as user '),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserLogin(
                                        isCompany: false,
                                      )));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(50, 0, 40, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(
                        child: const Text('Login as company '),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserLogin(
                                        isCompany: true,
                                      )));
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          child: const Text('CREATE COMPANY ACCOUNT'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CompanyAccountPage()));
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
