import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:holiday/local_data_source/user_local_data_source.dart';
import 'package:holiday/model/holiday_request_model.dart';
import 'package:uuid/uuid.dart';

import '../utils/enums.dart';

const String holiday_collection = "holiday";

class HolidayRequestProvider extends ChangeNotifier {
  bool isLoading = false;
  String? message;
  List<HolidayRequestModel> holidaysRequested = [];

  /// variable declaration for pending holidays
  List<HolidayRequestModel> pendingHolidas = [];

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> requestHoliday(HolidayRequestModel holidayRequestModel) async {
    try {
      isLoading = true;
      notifyListeners();

      var uuid = Uuid();
      final holidayId = uuid.v1();
      holidayRequestModel.holidayId = holidayId;

      holidayRequestModel.employeeId =
          await UserLocalDataSource.getEmployeeyId();
      holidayRequestModel.companyId = await UserLocalDataSource.getCompanyId();
      await firebaseFirestore
          .collection(holiday_collection)
          .add(holidayRequestModel.toMap());

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<void> getPendingHoliday() async {
    try {
      pendingHolidas = [];
      isLoading = true;
      notifyListeners();

      /// get data from holiday collection whose holiday request status is [false] and assigning that data to variable [result]
      final result = await firebaseFirestore
          .collection('holiday')
          .where('status', isEqualTo: HolidayStatus.PENDING.name)
          .get();

      /// since we get list of data in [result] variable, so iterating that list and mapping each element of list to [HolodayRequestModel]
      result.docs.forEach((element) {
        pendingHolidas.add(HolidayRequestModel.fromMap(element));
      });
      pendingHolidas;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<List<HolidayRequestModel>> getRequestedHolidays() async {
    try {
      isLoading = true;
      notifyListeners();
      final employeeid = await UserLocalDataSource.getEmployeeyId();
      log(employeeid);

      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await firebaseFirestore
              .collection(holiday_collection)
              .where("employeeId", isEqualTo: employeeid)
              .get();
      List<HolidayRequestModel> allHolidays = List<dynamic>.from(snapshot.docs)
          .map((e) => HolidayRequestModel.fromMap(e))
          .toList();

      holidaysRequested = allHolidays;
      isLoading = false;
      notifyListeners();
      return holidaysRequested;
    } catch (e) {
      throw e;
    }
  }

  Future updateHolidayStatus(String holidayId ,HolidayStatus holidaystatus ) async {
    try {
      final result = await firebaseFirestore
          .collection("holiday")
          .where("holidayId", isEqualTo: holidayId)
          .get();

      final documentId = result.docs[0].id;
      await firebaseFirestore
          .collection("holiday")
          .doc(documentId)
          .update({'status': holidaystatus.name});
      getPendingHoliday();
    } catch (e) {
      throw e;
    }
  }
}
