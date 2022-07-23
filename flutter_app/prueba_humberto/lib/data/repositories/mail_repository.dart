import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class MailRepository {
  Future<String> sendMail(String fromMail, String fromName, String toMail,
      String toName, String subject, String textPart, String htmlPart) async {
    final queryParameters = {
      'fromMail': fromMail,
      'fromName': fromName,
      'toMail': toMail,
      'toName': toName,
      'subject': subject,
      'textPart': textPart,
      'htmlPart': htmlPart,
    };
    var url = Uri.https("us-central1-ingreso1-7fb4e.cloudfunctions.net",
        "/sendMailByMailjet", queryParameters);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return "OK";
    } else {
      print(response.statusCode);
      return "ERROR";
    }
  }
}
