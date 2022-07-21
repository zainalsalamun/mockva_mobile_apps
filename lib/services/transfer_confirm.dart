import 'package:get/get_connect.dart';
import 'dart:convert';

class TransferConfirm extends GetConnect {
  final url =
      'https://mockva.daksa.co.id/mockva-rest/rest/account/transaction/transfer';

  Future<Response> reqTransferConfirm(String sessionId, String accountSrcId,
      String accountDstId, double amount, String inquiryId) {
    final body = json.encode({
      "accountSrcId": accountSrcId,
      "accountDstId": accountDstId,
      "amount": amount,
      "inquiry": inquiryId,
    });

    return post(url, body, headers: {"_sessionId": sessionId});
  }
}
