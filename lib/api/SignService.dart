import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:http/http.dart' as http;
import 'package:leasing_company/api/api.dart';

class SignService extends Api {
  Future<http.Response> signupBegin(int? tenantId) async {
    var response =
        await Api.client.post(Uri.parse(this.url + "/v1/auth/signup/begin"),
            body: jsonEncode({
              'tenant_id': tenantId,
            }),
            headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }).timeout(Duration(seconds: 15));
    return response;
  }

  Future<http.Response> signupFinish(
      int? tenantId,
      String firstname,
      String lastname,
      String patronymic,
      String company,
      String inn,
      String position,
      String phone,
      String email) async {
    var response =
        await Api.client.post(Uri.parse(this.url + "/v1/auth/signup/finish"),
            body: jsonEncode({
              'tenant_id': tenantId,
              'firstname': firstname,
              'lastname': lastname,
              'patronymic': patronymic,
              'company': company,
              'inn': inn,
              'position': position,
              'phone': phone,
              'email': email,
            }),
            headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }).timeout(Duration(seconds: 15));
    return response;
  }

  Future<http.Response> signin(String phone, String password) async {
    String? udid;
    try {
      udid = await FlutterUdid.udid;
    } on PlatformException {
      udid = null;
    }

    var response = await Api.client.post(Uri.parse(this.url + "/v1/auth/signin"),
        body: jsonEncode({
          'phone': phone,
          'password': password,
          'udid': udid,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }).timeout(Duration(seconds: 15));
    return response;
  }

  Future<http.Response> resetPassword(String phone) async {
    var response = await Api.client.post(Uri.parse(this.url + "/v1/auth/reset"),
        body: jsonEncode({
          'phone': phone,
        }),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }).timeout(Duration(seconds: 15));
    return response;
  }

  Future<http.Response> signout() async {
    String accessToken = this.appBox.get('accessToken');
    var response =
        await Api.client.post(Uri.parse(this.url + "/v1/auth/signout"), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + accessToken,
    }).timeout(Duration(seconds: 15));
    return response;
  }
}
