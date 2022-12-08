import 'package:cloud_firestore/cloud_firestore.dart';

class HolidayRequestModel {
  DateTime? starttime;
  DateTime? endtime;
  String? employeeId;
  String? companyId;
  String? holidayId;
  String status;

  HolidayRequestModel(
      {required this.endtime,
      required this.starttime,
      this.status = "PENDING",
      this.employeeId,
      this.companyId,
      this.holidayId});

  factory HolidayRequestModel.fromMap(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();

    return HolidayRequestModel(
      endtime: (data!['endtime'] as Timestamp).toDate(),
      starttime: data['sarttime'] == null
          ? null
          : (data['sarttime'] as Timestamp).toDate(),
      employeeId: data['employeeId'],
      companyId: data['companyId'],
      holidayId: data['holidayId'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'endtime': endtime,
      'sarttime': starttime,
      'status': status,
      'employeeId': employeeId,
      'companyId': companyId,
      'holidayId': holidayId,
    };
  }
}
