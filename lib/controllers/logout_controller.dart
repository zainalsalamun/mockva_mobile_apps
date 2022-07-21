import 'dart:ffi';
import 'package:get/get.dart';
import 'package:mockva_mobile_apps/views/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/auth/user_logout_service.dart';

class LogoutController extends GetxController {
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessionId = prefs.getString('sessionId');

    UserLogout().logoutUser(sessionId!).then((value) async {
      if (value.statusCode == 204) {
        Get.off(() => LoginPage);
      }
    });
  }
}
