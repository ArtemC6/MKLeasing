import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';

class RejectDelegateService extends Api {
  Future<http.Response> reject(
      String companyUuid,
      int reviewTemplateId,
      String reason,
      String newUserPhone,
      String newUserName,
      String newUserCompanyName,
      String newUserPosition) async {
    String accessToken = this.appBox.get('accessToken');
    var response = await Api.client.post(
        Uri.parse(this.url + "/v1/review-templates/$reviewTemplateId/reject"),
        body: jsonEncode({
          'reason': reason,
          'new_user_phone': newUserPhone,
          'new_user_name': newUserName,
          'new_user_company_name': newUserCompanyName,
          'new_user_position': newUserPosition
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
          'Tenant-Id': companyUuid,
        }).timeout(Duration(seconds: 15));
    return response;
  }

  Future<http.Response> checkPhoneForDelegate(
    String companyUuid,
    int reviewTemplateId,
    String phone,
  ) async {
    String accessToken = this.appBox.get('accessToken');
    var response = await Api.client.post(
        Uri.parse(this.url +
            "/v1/review-templates/$reviewTemplateId/check-phone-for-delegate"),
        body: jsonEncode({
          'phone': phone,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
          'Tenant-Id': companyUuid,
        }).timeout(Duration(seconds: 15));
    return response;
  }

  Future<http.Response> delegate(
      String companyUuid,
      int reviewTemplateId,
      String reason,
      String phone,
      String email,
      String firstname,
      String lastname,
      String companyName,
      String position) async {
    String accessToken = this.appBox.get('accessToken');
    var response = await Api.client.post(
        Uri.parse(this.url + "/v1/review-templates/$reviewTemplateId/delegate"),
        body: jsonEncode({
          'phone': phone,
          'reason': reason,
          'email': email,
          'firstname': firstname,
          'lastname': lastname,
          'company_name': companyName,
          'position': position
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + accessToken,
          'Tenant-Id': companyUuid,
        }).timeout(Duration(seconds: 15));
    return response;
  }
}
