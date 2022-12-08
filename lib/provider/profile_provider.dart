import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holiday/local_data_source/user_local_data_source.dart';
import 'package:holiday/model/company_model.dart';

class ProfileProvider extends ChangeNotifier {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  UserLocalDataSource userLocalDataSource = UserLocalDataSource();
  bool isLoading = false;

  Future<CompanyModel> getProfileInfomation() async {
    try {
      isLoading = true;
      notifyListeners();
      final companyeeId = await UserLocalDataSource.getCompanyId();
      print("company id $companyeeId");
      final result = await _firebaseFirestore
          .collection('company')
          .where("companyId", isEqualTo: companyeeId)
          .get();
      CompanyModel companymodel = CompanyModel.fromMap(result.docs.first);

      return companymodel;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw (e);
    }
  }
}
