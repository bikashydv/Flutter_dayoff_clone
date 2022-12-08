import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:holiday/screens/dashboard/dashboard_page/setting/setting.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assests/login/back2.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 95, top: 40),
            child: InkWell(
              onTap: () {
                print("Company profile");
              },
              child: CircleAvatar(
                radius: 115,
                backgroundColor: Colors.grey,
                child: CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage("assests/login/avtar.png"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 285,
              left: 152,
            ),
            child: Text(
              'Bikash yadav',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 420, left: 35),
            child: Text(
              "HOLIDAY",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 420, left: 305),
            child: Text(
              "SETTINGS",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 450, left: 40),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blueGrey),
                      child: Icon(Icons.calendar_month),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 450, right: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Setting()));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blueGrey),
                      child: Icon(Icons.settings),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 600, left: 125),
            child: Container(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 160,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blueGrey),
                  child: Text('Send Announcements'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
