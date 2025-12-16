import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageController {
  var tableId = ''.obs;
  var branchId = ''.obs;
  var name = ''.obs;
  var empCode = ''.obs;
  var number = ''.obs;
  var password = ''.obs;
  var role = ''.obs;

  //Save the Customer Details
  Future<void> saveUser(
    String tableId,
    String branchId,
    String name,
    String empCode,
    String number,
    String pasword,
    String role,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tableId', tableId);
    await prefs.setString('branchId', branchId);
    await prefs.setString('name', name);
    await prefs.setString('empCode', empCode);
    await prefs.setString('number', number);
    await prefs.setString('password', pasword);
    await prefs.setString('role', role);

    this.tableId.value = tableId;
    this.branchId.value = branchId;
    this.name.value = name;
    this.empCode.value = empCode;
    this.number.value = number;
    this.password.value = password.toString();
    this.role.value = role;
  }

  //Get the Details
  Future<Map<String, String?>> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'tableId': prefs.getString('tableId') ?? '',
      'branchId': prefs.getString('branchId') ?? '',
      'name': prefs.getString('name') ?? '',
      'empCode': prefs.getString('empCode') ?? '',
      'number': prefs.getString('number') ?? '',
      'password': prefs.getString('password') ?? '',
      'role': prefs.getString('role') ?? '',
    };
  }

  //Remove User
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    tableId.value = '';
    branchId.value = '';
    name.value = '';
    empCode.value = '';
    number.value = '';
    password.value = '';
    role.value = '';
  }
}
