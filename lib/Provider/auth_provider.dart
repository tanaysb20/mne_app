import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Modals/user.dart';
import 'package:mne/Reusable%20components/app_bar.dart';
import 'package:mne/core/constants/url_holder.dart';
import 'package:mne/core/services/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel? user;

  Future<bool> sendOtp(String phoneNos, String password) async {
    log(phoneNos + "sendd");
    log(password + "sendd");
    var response = await NetworkService.post(
      url: "${UrlHolder.baseUrl}${UrlHolder.login}",
      body: ({'phone': phoneNos, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var xyz = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();

      final authToken = xyz["token"];
      final id = xyz["user"]["_id"];
      final name = xyz["user"]["name"];
      final phoneNumber = xyz["user"]["phoneNumber"];
      final city = xyz["user"]["city"];
      final email = xyz["user"]["email"];

      await prefs.setString(
        "userToken",
        authToken.toString(),
      );

      await prefs.setString(
        "id",
        id.toString(),
      );
      await prefs.setString(
        "name",
        name.toString(),
      );
      await prefs.setString(
        "phoneNumber",
        phoneNumber.toString(),
      );
      await prefs.setString(
        "city",
        city.toString(),
      );
      await prefs.setString(
        "email",
        email.toString(),
      );
      await getUserDetails();

      notifyListeners();

      return true;
    } else {
      var xyz = json.decode(response.body);
      final responseData = xyz["errors"][0]["msg"];
      message(responseData);
      return false;
    }
  }

  Future getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var txid = await prefs.getString("id");
    var txname = await prefs.getString("name");
    var txphoneNumber = await prefs.getString("phoneNumber");
    var txcity = await prefs.getString("city");
    var txemail = await prefs.getString("email");

    user = UserModel(
        city: txcity ?? "",
        sId: txid ?? "",
        email: txemail ?? "",
        name: txname ?? "",
        phoneNumber: txphoneNumber ?? "");

    notifyListeners();
  }
}
