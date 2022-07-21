import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mockva_mobile_apps/controllers/logout_controller.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  final logoutC = Get.put(LogoutController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          logoutC.logout();
        },
        child: const Text('Logout'),
      ),
    );
  }
}
