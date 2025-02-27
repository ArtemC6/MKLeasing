import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';

class ConfigService extends Api {
  Future<http.Response> get() async {
    var response = await Api.client
        .post(Uri.parse("${this.url}/v1/config/app"), body: {
      'version': this.version,
    }, headers: {
      'Accept': 'application/json'
    }).timeout(Duration(seconds: 5),
            onTimeout: () => http.Response('Timeout', 408));
    return response;
  }
}
