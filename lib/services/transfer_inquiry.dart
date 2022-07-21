import 'dart:convert';
import 'package:get/get_connect.dart';

class TransferInquiry extends GetConnect {
  final url =
      'https://mockva.daksa.co.id/mockva-rest/rest/account/transaction/transferInquiry';

  Future<Response> reqTransferInquiry(
      String sessionId, String accountId, String accountDstId, String amount) {
    final body = json.encode({
      "accountSrcId": accountId,
      "accountDstId": accountDstId,
      "amount": double.parse(amount),
    });
    return post(url, body, headers: {"_session": sessionId});
  }
}
