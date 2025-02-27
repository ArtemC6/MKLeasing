// import 'package:flutter_udid/flutter_udid.dart';
// import 'package:http_interceptor/http_interceptor.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// import 'api.dart';
//
// class CommonInterceptor extends Api implements InterceptorContract {
//   @override
//   Future<RequestData> interceptRequest({required RequestData data}) async {
//     PackageInfo  packageInfo = await PackageInfo.fromPlatform();
//     try {
//       data.headers['Device-Uuid'] = await FlutterUdid.udid;
//       data.headers['Device-Model'] =Api.deviceModel;
//       data.headers['Version'] = this.version;
//       data.headers['Package'] = packageInfo.packageName;
//     } catch (e,s) {
//       print(e);
//       print(s);
//     }
//     return data;
//   }
//
//   @override
//   Future<ResponseData> interceptResponse({required ResponseData data}) async {
//     return data;
//   }
// }
//
