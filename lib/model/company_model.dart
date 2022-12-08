import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  String companyName;
  String address;
  String phoneNumber;
  String email;
  String? companyId;
  String? userId;

  CompanyModel(
      {required this.address,
      required this.companyName,
      required this.phoneNumber,
      required this.email,
      this.companyId,
      this.userId,
      i});

  factory CompanyModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return CompanyModel(
        address: data['address'],
        companyName: data['companyName'],
        phoneNumber: data['phoneNumber'],
        companyId: data['companyId'],
        userId: data['userId'],
        email: data['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'email': email,
      'companyId': companyId,
      'employeeId': userId,
    };
  }
}
