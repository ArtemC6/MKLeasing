import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';

class NotificationService extends Api {
  Future<http.Response> getIndex() async {
    String accessToken = this.appBox.get('accessToken');
    var response = await Api.client
        .get(Uri.parse(this.url + "/v1/notifications"), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + accessToken,
    }).timeout(Duration(seconds: 15));
    return response;
  }
}
