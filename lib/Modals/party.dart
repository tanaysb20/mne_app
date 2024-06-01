import 'package:hive/hive.dart';

part 'party.g.dart';

@HiveType(typeId: 1)
class PartyModel {
  @HiveField(0)
  String? sId;
  @HiveField(1)
  String? partyName;
  @HiveField(2)
  String? phoneNumber;
  @HiveField(3)
  String? email;
  @HiveField(4)
  String? city;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  String? updatedAt;
  @HiveField(7)
  int? iV;

  PartyModel({this.sId,
    this.partyName,
    this.phoneNumber,
    this.email,
    this.city,
    this.createdAt,
    this.updatedAt,
    this.iV});

  PartyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    partyName = json['partyName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    city = json['city'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['partyName'] = this.partyName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['city'] = this.city;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }

  bool operator ==(dynamic other) =>
      other != null && other is PartyModel && this.sId == other.sId;

  @override
  int get hashCode => super.hashCode;
}
