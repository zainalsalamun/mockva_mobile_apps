import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mockva_mobile_apps/controllers/login_controller.dart';
import 'package:mockva_mobile_apps/controllers/transfer_inquiry_controller.dart';
import 'package:mockva_mobile_apps/services/account_detail.dart';
import 'package:mockva_mobile_apps/services/transfer_confirm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menu_controller.dart';

class TransferConfirmController extends GetxController {
  final tfInqC = Get.find<TransferInquiryController>();

  late String timeStamp;
  late String clientRef;
  late String status;

  Future<void> transferConfirm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sessionId = prefs.getString('sessionId');
    var accountId = prefs.getString('accountId');

    TransferConfirm()
        .reqTransferConfirm(sessionId!, accountId!, tfInqC.dstAccId,
            tfInqC.tfAmount, tfInqC.inquiryId)
        .then((value) async {
      if (value.statusCode == 200) {
        status = 'SUCCESS';
        timeStamp = await value.body['transactionTimestamp'];
        clientRef = await value.body['clientRef'];

        Get.find<MenuController>().pageIndex.value = 5;

        AccountDetail().detailUser(sessionId, accountId).then((value) {
          Get.find<LoginController>().accBalance.value =
              value.body['balance'].toString();
        });
      } else {
        Get.defaultDialog(
            title: 'Error',
            content: Text(value.body),
            confirm: ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('Ok'),
            ));
      }
    });
  }
}
