import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:holiday/local_data_source/user_local_data_source.dart';
import 'package:holiday/provider/auth_provider.dart';
import 'package:holiday/provider/holiday%20_request_provider.dart';
import 'package:holiday/provider/profile_provider.dart';
import 'package:holiday/screens/logins/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserLocalDataSource.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HolidayRequestProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginFirstPage(),
      ),
    );
  }
}
