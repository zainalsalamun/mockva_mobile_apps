import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/account_detail.dart';
import '../services/auth/user_login_service.dart';
import '../views/menu.dart';

class LoginController extends GetxController {
  final txtUsrC = TextEditingController();
  final txtPassC = TextEditingController();

  late String accNumber;
  late String accName;
  var accBalance = ''.obs;

  @override
  void dispose() {
    txtPassC.dispose();
    txtUsrC.dispose();
    super.dispose();
  }

  Future<void> login(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    UserLogin().loginUser(username, password).then((value) async {
      if (value.statusCode == 200) {
        prefs.setString('sessionId', value.body['id']);
        prefs.setString('sessionId', value.body['accountId']);

        await AccountDetail()
            .detailUser(value.body['id'], value.body['accountId'])
            .then((value) {
          accNumber = value.body['id'];
          accName = value.body['name'];
          accBalance.value = value.body['balance'].toString();

          txtPassC.clear();
          txtUsrC.clear();
          Get.off(() => Menu());
        });
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text(value.body),
            confirm: ElevatedButton(
                onPressed: () => Get.back(), child: const Text('OK')));
      }
    });
  }
}
