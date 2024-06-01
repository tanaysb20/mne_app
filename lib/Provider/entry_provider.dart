import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mne/Modals/entry.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Provider/auth_provider.dart';
import 'package:mne/core/constants/url_holder.dart';
import 'package:mne/core/services/network_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryProvider extends ChangeNotifier {
  EntryProvider() {
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        isConnected = false;
      } else {
        isConnected = true;
        uploadOfflineEntryDetails();
      }
      notifyListeners();
    });
  }

  bool isConnected = false;
  List<PartyModel> partyList = [];
  List<EntryModel> entryList = [];
  String? partyId;
  String? entryId;
  TextEditingController partyName = TextEditingController();
  TextEditingController partyEmail = TextEditingController();
  TextEditingController partyPhone = TextEditingController();
  TextEditingController partyCity = TextEditingController();

  initPartyEdit({PartyModel? party}) {
    if (party == null) {
      partyId = null;
      partyName = TextEditingController();
      partyEmail = TextEditingController();
      partyPhone = TextEditingController();
      partyCity = TextEditingController();
    } else {
      partyId = party.sId;
      partyName.text = party.partyName ?? "";
      partyEmail.text = party.email ?? "";
      partyPhone.text = party.phoneNumber ?? "";

      partyCity.text = party.city ?? "";
    }
    notifyListeners();
  }

  Future getPartyList() async {
    try {
      var response = await NetworkService.get(
        url: "${UrlHolder.baseUrl}${UrlHolder.getParty}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<PartyModel> demoPartyList = [];
        var xyz = json.decode(response.body);
        xyz.forEach((element) {
          return demoPartyList.add(PartyModel.fromJson(element));
        });
        partyList = demoPartyList;
        var partyBox = Hive.box<PartyModel>('partyBox');
        await partyBox.deleteAll(partyBox.keys);
        partyList.forEach((element) async {
          await partyBox.add(element);
        });
        notifyListeners();
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      partyList = [];
      var partyBox = Hive.box<PartyModel>('partyBox');
      partyList = partyBox.values.toList();
    }
  }

  Future savePartyDetails({required BuildContext context}) async {
    try {
      if (partyName.text.isEmpty) {
        EasyLoading.showError("Party Name cannot be empty");
        return;
      } else if (partyEmail.text.isEmpty) {
        EasyLoading.showError("Party Email cannot be empty");
        return;
      } else if (partyPhone.text.isEmpty) {
        EasyLoading.showError("Party Phone cannot be empty");
        return;
      } else if (partyCity.text.isEmpty) {
        EasyLoading.showError("Party City cannot be empty");
        return;
      }

      EasyLoading.show();
      var response = await (partyId == null
          ? NetworkService.post(
              url: "${UrlHolder.baseUrl}${UrlHolder.getParty}",
              body: {
                "partyName": partyName.text,
                "email": partyEmail.text,
                "phoneNumber": partyPhone.text,
                "city": partyCity.text
              },
            )
          : NetworkService.put(
              url: "${UrlHolder.baseUrl}${UrlHolder.getParty}/$partyId",
              body: {
                "partyName": partyName.text,
                "email": partyEmail.text,
                "phoneNumber": partyPhone.text,
                "city": partyCity.text
              },
            ));
      EasyLoading.dismiss();
      if (response.statusCode == 200 || response.statusCode == 201) {
        initPartyEdit();
        getPartyList();
        Navigator.of(context).pop();
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  DateTime entryDate = DateTime.now();
  PartyModel? entryParty;
  String materialCenter = "YARD";
  TextEditingController materialCenterText = TextEditingController();
  TextEditingController mark = TextEditingController();
  TextEditingController numberOfBags = TextEditingController();
  TextEditingController startSno = TextEditingController();
  TextEditingController ratePerQuintal = TextEditingController();
  List<BagsModel> bags = [];
  TextEditingController totalWeight = TextEditingController();
  TextEditingController lessTare = TextEditingController();
  TextEditingController netWeight = TextEditingController();

  initEntryEdit({EntryModel? entry}) {
    if (entry == null) {
      entryDate = DateTime.now();
      entryParty = null;
      materialCenter = "YARD";
      materialCenterText = TextEditingController();
      mark = TextEditingController();
      numberOfBags = TextEditingController();
      startSno = TextEditingController();
      ratePerQuintal = TextEditingController();
      bags = [];
      totalWeight = TextEditingController();
      lessTare = TextEditingController();
      netWeight = TextEditingController();
      entryId = null;
    } else {
      entryDate = DateTime.tryParse(entry.date.toString()) ?? DateTime.now();
      entryParty = entry.party ?? null;
      materialCenter = entry.materialCenter ?? "YARD";
      materialCenterText.text = entry.materialCenterText ?? "";
      mark.text = entry.mark ?? "";
      numberOfBags.text = (entry.noOfBags ?? "").toString();
      startSno.text = (entry.sNo ?? "").toString();
      ratePerQuintal.text = (entry.ratePerQuintal ?? "").toString();
      bags = entry.bags ?? [];
      totalWeight.text = (entry.totalWeight ?? "").toString();
      lessTare.text = (entry.lessTare ?? "").toString();
      netWeight.text = (entry.netWeight ?? "").toString();
      entryId = entry.sId;
    }
    notifyListeners();
  }

  updateDate(BuildContext context) async {
    entryDate = await showDateTimePicker(
            context: context,
            firstDate: DateTime.now().subtract(Duration(days: 365 * 5)),
            initialDate: entryDate,
            lastDate: DateTime.now()) ??
        entryDate;
    notifyListeners();
  }

  updateParty(PartyModel party) async {
    entryParty = party;
    notifyListeners();
  }

  updateMaterialCenter(String val) async {
    materialCenter = val;
    notifyListeners();
  }

  updateBagListLength() async {
    if (numberOfBags.text.isNotEmpty &&
        int.tryParse(numberOfBags.text) != null) {
      if (bags.length < int.parse(numberOfBags.text)) {
        for (int i = 0; i < bags.length; i++) {
          bags[i].sNo = (int.tryParse(startSno.text) ?? 1) + i;
        }
        for (int i = bags.length; i < int.parse(numberOfBags.text); i++) {
          bags.add(
            BagsModel(sNo: (int.tryParse(startSno.text) ?? 1) + i),
          );
        }
      } else {
        bags = bags.sublist(0, int.parse(numberOfBags.text));
      }
    }
    notifyListeners();
  }

  removeBagAtSno({required int sno}) {
    int index = bags.indexWhere((element) => element.sNo == sno);
    for (int i = index; i < bags.length - 1; i++) {
      bags[i].weight = bags[i + 1].weight;
    }

    bags.removeLast();
    numberOfBags.text = (int.parse(numberOfBags.text) - 1).toString();

    notifyListeners();
  }

  updateStartSno() {
    for (int i = 0; i < bags.length; i++) {
      bags[i].sNo = (int.tryParse(startSno.text) ?? 1) + i;
    }
    notifyListeners();
  }

  updateBagWeight({required int index, required double weight}) {
    bags[index].weight = weight.roundToDouble();
    updateTotals();
  }

  updateTotals() async {
    double totalweight = 0;
    bags.forEach((element) {
      totalweight += element.weight ?? 0;
    });
    totalWeight.text = totalweight.toString();
    netWeight.text =
        (totalweight - (double.tryParse(lessTare.text) ?? 0)).toString();
    notifyListeners();
  }

  Future getEntryList() async {
    try {
      var response = await NetworkService.get(
        url: "${UrlHolder.baseUrl}${UrlHolder.getEntry}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<EntryModel> demoEntryList = [];
        var xyz = json.decode(response.body);
        xyz.forEach((element) {
          return demoEntryList.add(EntryModel.fromJson(element));
        });
        entryList = demoEntryList;
        var entryBox = Hive.box<EntryModel>('entryBox');
        await entryBox.deleteAll(entryBox.keys);
        entryList.forEach((element) async {
          await entryBox.add(element);
        });
        notifyListeners();
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      entryList = [];
      var entryBox = Hive.box<EntryModel>('entryBox');
      entryList = entryBox.values.toList();
    }
  }

  Future saveEntryDetails({required BuildContext context}) async {
    try {
      if (entryParty == null) {
        EasyLoading.showError("Party Name cannot be empty");
        return;
      } else if (mark.text.isEmpty) {
        EasyLoading.showError("Mark cannot be empty");
        return;
      } else if (numberOfBags.text.isEmpty) {
        EasyLoading.showError("Number of bags cannot be empty");
        return;
      } else if (startSno.text.isEmpty) {
        EasyLoading.showError("Start S. No. cannot be empty");
        return;
      } else if (ratePerQuintal.text.isEmpty) {
        EasyLoading.showError("Rate per Quintal cannot be empty");
        return;
      } else if (bags.where((element) => element.weight == null).length > 0) {
        EasyLoading.showError("Weight of bags cannot be empty");
        return;
      }

      List<Map> bagtemp = [];
      bags.forEach((element) {
        bagtemp.add(element.toJson());
      });
      if (isConnected) {
        EasyLoading.show();
        var response = await (entryId == null || entryId!.contains("temp")
            ? NetworkService.post(
                url: "${UrlHolder.baseUrl}${UrlHolder.getEntry}",
                body: {
                  "sNo": startSno.text,
                  "mark": mark.text,
                  "materialCenterText": materialCenterText.text,
                  "date": entryDate.toIso8601String(),
                  "party": entryParty!.sId,
                  "ratePerQuintal": double.tryParse(ratePerQuintal.text) ?? 0,
                  "materialCenter": materialCenter,
                  "noOfBags": int.tryParse(numberOfBags.text) ?? 0,
                  "lessTare": double.tryParse(lessTare.text) ?? 0,
                  "totalWeight": double.tryParse(totalWeight.text) ?? 0,
                  "netWeight": double.tryParse(netWeight.text) ?? 0,
                  "bags": bagtemp,
                },
              )
            : NetworkService.put(
                url: "${UrlHolder.baseUrl}${UrlHolder.getEntry}/$entryId",
                body: {
                  "sNo": startSno.text,
                  "mark": mark.text,
                  "materialCenterText": materialCenterText.text,
                  "date": entryDate.toIso8601String(),
                  "party": entryParty!.sId,
                  "ratePerQuintal": double.tryParse(ratePerQuintal.text) ?? 0,
                  "materialCenter": materialCenter,
                  "noOfBags": int.tryParse(numberOfBags.text) ?? 0,
                  "lessTare": double.tryParse(lessTare.text) ?? 0,
                  "totalWeight": double.tryParse(totalWeight.text) ?? 0,
                  "netWeight": double.tryParse(netWeight.text) ?? 0,
                  "bags": bagtemp,
                },
              ));
        EasyLoading.dismiss();
        if (response.statusCode == 200 || response.statusCode == 201) {
          initEntryEdit();
          getEntryList();
          Navigator.of(context).pop();
        } else {
          print(response.reasonPhrase);
        }
      } else {
        var entryBox = Hive.box<EntryModel>('entryBox');
        List<Map> bagtemp = [];
        bags.forEach((element) {
          bagtemp.add(element.toJson());
        });
        if (entryId == null) {
          await entryBox.add(EntryModel.fromJson(
            {
              "_id": "temp" + getRandomString(22),
              "user": Provider.of<AuthProvider>(context, listen: false)
                  .user!
                  .toJson(),
              "sNo": startSno.text,
              "mark": mark.text,
              "date": entryDate.toIso8601String(),
              "party": entryParty!.toJson(),
              "ratePerQuintal": double.tryParse(ratePerQuintal.text) ?? 0,
              "materialCenter": materialCenter,
              "materialCenterText": materialCenterText.text,
              "noOfBags": int.tryParse(numberOfBags.text) ?? 0,
              "lessTare": double.tryParse(lessTare.text) ?? 0,
              "totalWeight": double.tryParse(totalWeight.text) ?? 0,
              "netWeight": double.tryParse(netWeight.text) ?? 0,
              "bags": bagtemp,
              "createdAt": DateTime.now().toIso8601String(),
              "updatedAt": DateTime.now().toIso8601String(),
              "uploaded": false,
              "__v": 1
            },
          ));
        } else {
          int index = entryBox.values
              .toList()
              .indexWhere((element) => element.sId == entryId);
          await entryBox.putAt(
              index,
              EntryModel.fromJson(
                {
                  "_id": entryId,
                  "user": Provider.of<AuthProvider>(context, listen: false)
                      .user!
                      .toJson(),
                  "sNo": startSno.text,
                  "mark": mark.text,
                  "date": entryDate.toIso8601String(),
                  "party": entryParty!.toJson(),
                  "ratePerQuintal": double.tryParse(ratePerQuintal.text) ?? 0,
                  "materialCenter": materialCenter,
                  "materialCenterText": materialCenterText.text,
                  "noOfBags": int.tryParse(numberOfBags.text) ?? 0,
                  "lessTare": double.tryParse(lessTare.text) ?? 0,
                  "totalWeight": double.tryParse(totalWeight.text) ?? 0,
                  "netWeight": double.tryParse(netWeight.text) ?? 0,
                  "bags": bagtemp,
                  "createdAt": DateTime.now().toIso8601String(),
                  "updatedAt": DateTime.now().toIso8601String(),
                  "uploaded": false,
                  "__v": 1
                },
              ));
        }

        getEntryList();
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
      EasyLoading.dismiss();
    }
  }

  Future uploadOfflineEntryDetails() async {
    try {
      EasyLoading.show();
      var entryBox = Hive.box<EntryModel>('entryBox');
      entryBox.values.forEach((element) async {
        if (element.uploaded == false) {
          if (isConnected) {
            List<Map> bagtemp = [];
            element.bags?.forEach((element2) {
              bagtemp.add(element2.toJson());
            });
            var response = await (element.sId == null ||
                    element.sId!.contains("temp")
                ? NetworkService.post(
                    url: "${UrlHolder.baseUrl}${UrlHolder.getEntry}",
                    body: {
                      "sNo": element.sNo,
                      "mark": element.mark,
                      "materialCenterText": element.materialCenterText,
                      "date": element.date,
                      "party": element.party!.sId,
                      "ratePerQuintal": element.ratePerQuintal,
                      "materialCenter": element.materialCenter,
                      "noOfBags": element.noOfBags,
                      "lessTare": element.lessTare,
                      "totalWeight": element.totalWeight,
                      "netWeight": element.netWeight,
                      "bags": bagtemp,
                    },
                  )
                : NetworkService.put(
                    url: "${UrlHolder.baseUrl}${UrlHolder.getEntry}/$entryId",
                    body: {
                      "sNo": element.sNo,
                      "mark": element.mark,
                      "materialCenterText": element.materialCenterText,
                      "date": element.date,
                      "party": element.party!.sId,
                      "ratePerQuintal": element.ratePerQuintal,
                      "materialCenter": element.materialCenter,
                      "noOfBags": element.noOfBags,
                      "lessTare": element.lessTare,
                      "totalWeight": element.totalWeight,
                      "netWeight": element.netWeight,
                      "bags": bagtemp,
                    },
                  ));
            EasyLoading.dismiss();
            if (response.statusCode == 200 || response.statusCode == 201) {
              getEntryList();
            } else {
              print(response.reasonPhrase);
            }
          } else {
            EasyLoading.showError("Unstable network");
          }
        }
      });
    } catch (e) {
      EasyLoading.dismiss();
    }
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 100));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
