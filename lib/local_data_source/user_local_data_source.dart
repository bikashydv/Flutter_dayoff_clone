import 'package:shared_preferences/shared_preferences.dart';

const String USER_ID = "USER_ID";
const String EMPLOYEE_ID = "EMPLOYEE_ID";
const String COMPANY_ID = "COMPANY_ID";

class UserLocalDataSource {
  static Future<SharedPreferences> get _instance async =>
      await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  Future<void> saveUserId(String employeeId) async {
    await _prefsInstance.setString(USER_ID, employeeId);
  }

  static Future<String> getCompanyId() async {
    return await _prefsInstance.getString(COMPANY_ID) ?? "";
  }

  static setCompanyId(String companyId) async {
    _prefsInstance.setString(COMPANY_ID, companyId);
  }

//

  static Future<String> getEmployeeyId() async {
    return await _prefsInstance.getString(EMPLOYEE_ID) ?? "";
  }
  

  static setEmployeeId(String employeeId) async {
    _prefsInstance.setString(EMPLOYEE_ID, employeeId);
  }

//for logout
  static Future<void> clearAllUserData() async {
    await _prefsInstance.clear();
  }
}
