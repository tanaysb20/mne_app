import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Modals/user.dart';
import 'package:mne/Reusable%20components/app_bar.dart';
import 'package:mne/Urls/url_holder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModal? user;
  List<PartyModal> partyList = [];

  Future<bool> sendOtp(String phoneNos, String password) async {
    log(phoneNos + "sendd");
    log(password + "sendd");
    final prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var request =
        Request('POST', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.login}'));
    request.body = json.encode({'phone': phoneNos, 'password': password});
    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final authToken = json.decode(xyz)["token"];
      final id = json.decode(xyz)["user"]["_id"];
      final name = json.decode(xyz)["user"]["name"];
      final phoneNumber = json.decode(xyz)["user"]["phoneNumber"];
      final city = json.decode(xyz)["user"]["city"];
      final email = json.decode(xyz)["user"]["email"];

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
      final xyz = await response.stream.bytesToString();
      final responseData = json.decode(xyz)["errors"][0]["msg"];
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

    user = UserModal(
        city: txcity ?? "",
        id: txid ?? "",
        email: txemail ?? "",
        name: txname ?? "",
        phoneNumber: txphoneNumber ?? "");

    notifyListeners();
  }

  Future getPartyList() async {
    final prefs = await SharedPreferences.getInstance();
    var token = await prefs.getString("userToken");
    var headers = {'Authorization': '$token'};
    var request =
        Request('GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.getParty}'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    List<PartyModal> demoPartyList = [];

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz);

      responseData.forEach((element) {
        return demoPartyList.add(PartyModal(
            city: element["city"] ?? "",
            email: element["email"] ?? "",
            id: element["_id"] ?? "",
            partyName: element["partyName"] ?? "",
            phoneNumber: element["phoneNumber"] ?? ""));
      });

      partyList = demoPartyList;
      log("${partyList.length} party lengthhh");
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }
}
