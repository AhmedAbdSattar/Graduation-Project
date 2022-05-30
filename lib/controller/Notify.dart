import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> callOnFcmApiSendPushNotifications(
    {required String title, required String body, required String Token}) async {
  print('here token $Token');
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  final data = {
    "to": "$Token",
    "notification": {
      "title": title,
      "body": body,
    },
    "data": {
      "type": 'report matched',
      "click_action": 'FLUTTER_NOTIFICATION_CLICK',
    }
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization':
    'key= AAAAEgwblLI:APA91bHoYG8yuOkKeH_Y9VtPll17r9Wg95agn3_ijasc5Yu0HMNXEqiygBd-OENdC7k1z94sme9BjvFUJHC6nWFkhCngkP1acZCSlFUueu5Gto8fx1hQOaLlDamZZfuCHwkNyYCeUP0O ' // 'key=YOUR_SERVER_KEY'
  };

  final response = await http.post(Uri.parse(postUrl),
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers);

  if (response.statusCode == 200) {
    // on success do sth
    print('test ok push CFM');
    return true;
  } else {
    print(' CFM error');
    // on failure do sth
    return false;
  }

}
