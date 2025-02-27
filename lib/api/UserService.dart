import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class UserService extends Api {
  Future<http.Response> me() async {
    String accessToken = this.appBox.get('accessToken');
    var response =
        await Api.client.get(Uri.parse(this.url + "/v1/users/me"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + accessToken,
    }).timeout(Duration(seconds: 15));
    return response;
  }

  Future<http.Response?> setToken() async {
    String accessToken = this.appBox.get('accessToken');
    String? firebaseToken;
    try {
      FirebaseMessaging _fcm = FirebaseMessaging.instance;
      firebaseToken = await _fcm.getToken().timeout(Duration(seconds: 1));
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
    if (firebaseToken == null) {
      return null;
    }
    var response =
        await Api.client.patch(Uri.parse(this.url + "/v1/users/set_token"), body: {
      'firebase_token': firebaseToken,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + accessToken,
    });
    return response;
  }
}
