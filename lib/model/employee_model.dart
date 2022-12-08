// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  String name;
  String email;
  String phoneNumber;
  String password;
  String address;
  String? companyid;
  String? employeeid;

  EmployeeModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.address,
    this.companyid,
    this.employeeid,
  });

  factory EmployeeModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return EmployeeModel(
      name: data['name'],
      email: data['email'],
      password: data['password'],
      address: data['address'],
      phoneNumber: data['phoneNumber'],
      companyid: data['companyid'],
      employeeid: data['employeeid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'address': address,
      'phoneNumber': phoneNumber,
      'name': name,
      'companyid': companyid,
      'employeeid': employeeid,
    };
  }
}
