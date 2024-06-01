import 'package:hive/hive.dart';
import 'package:mne/Modals/party.dart';
import 'package:mne/Modals/user.dart';

part 'entry.g.dart';

@HiveType(typeId: 2)
class EntryModel {
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? sNo;
  @HiveField(2)
  String? mark;
  @HiveField(3)
  String? date;
  @HiveField(4)
  PartyModel? party;
  @HiveField(5)
  int? ratePerQuintal;
  @HiveField(6)
  String? materialCenter;
  @HiveField(7)
  int? noOfBags;
  @HiveField(8)
  int? lessTare;
  @HiveField(9)
  int? totalWeight;
  @HiveField(10)
  int? netWeight;
  @HiveField(11)
  List<BagsModel>? bags;
  @HiveField(12)
  String? createdAt;
  @HiveField(13)
  String? updatedAt;
  @HiveField(14)
  int? iV;
  @HiveField(15)
  String? materialCenterText;
  @HiveField(16)
  Picture? picture;
  @HiveField(17)
  UserModel? user;
  @HiveField(18)
  bool? uploaded;

  EntryModel(
      {this.picture,
      this.sId,
      this.user,
      this.sNo,
      this.mark,
      this.date,
      this.party,
      this.ratePerQuintal,
      this.materialCenter,
      this.noOfBags,
      this.lessTare,
      this.totalWeight,
      this.netWeight,
      this.bags,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.materialCenterText,
      this.uploaded});

  EntryModel.fromJson(Map<String, dynamic> json) {
    picture =
        json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
    sId = json['_id'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    sNo = json['sNo'];
    mark = json['mark'];
    date = json['date'];
    party =
        json['party'] != null ? new PartyModel.fromJson(json['party']) : null;
    ratePerQuintal = (json['ratePerQuintal'] * 1.0).floor();
    materialCenter = json['materialCenter'];
    noOfBags = json['noOfBags'];
    lessTare = (json['lessTare'] * 1.0).floor();
    totalWeight = (json['totalWeight'] * 1.0).floor();
    netWeight = (json['netWeight'] * 1.0).floor();
    if (json['bags'] != null) {
      bags = <BagsModel>[];
      json['bags'].forEach((v) {
        bags!.add(new BagsModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    materialCenterText = json['materialCenterText'];
    uploaded = json['uploaded'] ?? true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.picture != null) {
      data['picture'] = this.picture!.toJson();
    }
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['sNo'] = this.sNo;
    data['mark'] = this.mark;
    data['date'] = this.date;
    if (this.party != null) {
      data['party'] = this.party!.toJson();
    }
    data['ratePerQuintal'] = this.ratePerQuintal;
    data['materialCenter'] = this.materialCenter;
    data['noOfBags'] = this.noOfBags;
    data['lessTare'] = this.lessTare;
    data['totalWeight'] = this.totalWeight;
    data['netWeight'] = this.netWeight;
    if (this.bags != null) {
      data['bags'] = this.bags!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['materialCenterText'] = this.materialCenterText;
    data['uploaded'] = this.uploaded;
    return data;
  }
}

@HiveType(typeId: 3)
class Picture {
  @HiveField(0)
  String? mediaUrl;
  @HiveField(1)
  String? mediaRef;

  Picture({this.mediaUrl, this.mediaRef});

  Picture.fromJson(Map<String, dynamic> json) {
    mediaUrl = json['mediaUrl'];
    mediaRef = json['mediaRef'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaUrl'] = this.mediaUrl;
    data['mediaRef'] = this.mediaRef;
    return data;
  }
}

@HiveType(typeId: 4)
class BagsModel {
  @HiveField(0)
  int? sNo;
  @HiveField(1)
  double? weight;

  BagsModel({this.sNo, this.weight});

  BagsModel.fromJson(Map<String, dynamic> json) {
    sNo = json['sNo'];
    weight = json['weight'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sNo'] = this.sNo;
    data['weight'] = this.weight;
    return data;
  }
}
