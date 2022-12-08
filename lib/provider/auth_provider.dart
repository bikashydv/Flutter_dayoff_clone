import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:holiday/local_data_source/user_local_data_source.dart';
import 'package:holiday/screens/dashboard/dashboard_page/calender/holiday.dart';
import 'package:uuid/uuid.dart';

import '../model/employee_model.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  bool isLoading = false;

  //signup

  Future<void> signUpWithEmailAndPassword(
      String email,
      String password,
      String companyName,
      String address,
      String phoneNumber,
      BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uId = result.user!.uid;
      final _email = result.user!.email!;
      await saveCompanyInfoIntoDatabase(
          _email, uId, companyName, address, phoneNumber);
      isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.code == 'week-password') {
        final Snackbar =
            SnackBar(content: Text(' The password provided is too week '));
        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
        print('The password provided is too week ');
      } else if (e.code == 'email-already-in-use') {
        final Snackbar = SnackBar(
            content: Text(' The account already exist for that  email '));
        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
        print('The account already exist for that  email');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  // to login  their user

  Future<bool> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final result = await _firebaseFirestore
          .collection('company')
          .where('email', isEqualTo: email)
          .get();

      final companyId = result.docs.first.data()['companyId'];
      UserLocalDataSource.setCompanyId(companyId);

      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.code == 'user not found') {
        print('No user found for that email.');
        final Snackbar =
            SnackBar(content: Text('No user found for that email.'));
        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
      } else if (e.code == 'wrong password') {
        print('Wrong password for  that user');
        final Snackbar =
            SnackBar(content: Text(' password  you enter is worng'));
        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
      }
      return false;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  // to store siggend up user into firebase database in the collection [users]

  Future<void> saveCompanyInfoIntoDatabase(String email, String uId,
      String companyName, String address, String phoneNumber) async {
    var uuid = Uuid();
    final companyId = uuid.v1();
    await _firebaseFirestore.collection("company").add({
      "email": email,
      "userId": uId,
      "companyName": companyName,
      "address": address,
      "phoneNumber": phoneNumber,
      "companyId": companyId,
    });
  }

  Future addEmployeeOfCompany(
      EmployeeModel employee, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await _firebaseFirestore
          .collection('employee')
          .where("email", isEqualTo: employee.email)
          .get();

      if (result.docs.length == 0) {
        employee.companyid = await UserLocalDataSource.getCompanyId();
        var uuid = Uuid();
        employee.employeeid = uuid.v1();

        await _firebaseFirestore.collection("employee").add(employee.toMap());
        isLoading = false;
        notifyListeners();
        final Snackbar = SnackBar(content: Text('employee succfullfy added'));
        ScaffoldMessenger.of(context).showSnackBar(Snackbar);
      } else {
        final snackBar = SnackBar(content: Text('email already exist'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      final Snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(Snackbar);
    }
  }

  Future<bool> logInUserOfTheCompany(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      UserLocalDataSource.getEmployeeyId();

      final result = await _firebaseFirestore
          .collection("employee")
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get();

      isLoading = false;
      notifyListeners();
      if (result.docs.length == 1) {
        final data = result.docs[0];
        EmployeeModel em = EmployeeModel.fromMap(data);
        UserLocalDataSource.setEmployeeId(em.employeeid!);
        UserLocalDataSource.setCompanyId(em.companyid!);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveUserInfoIntoDatabase(
      String employeeName,
      String employeeEmail,
      String emlpyeeNumber,
      String employeePassword) async {
    await _firebaseFirestore.collection("employee").add({
      "name": employeeName,
      "email": employeeEmail,
      "number": emlpyeeNumber,
      "password": employeePassword,
    });
  }
}
