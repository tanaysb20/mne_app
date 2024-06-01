// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntryModelAdapter extends TypeAdapter<EntryModel> {
  @override
  final int typeId = 2;

  @override
  EntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntryModel(
      picture: fields[16] as Picture?,
      sId: fields[0] as String?,
      user: fields[17] as UserModel?,
      sNo: fields[1] as String?,
      mark: fields[2] as String?,
      date: fields[3] as String?,
      party: fields[4] as PartyModel?,
      ratePerQuintal: fields[5] as int?,
      materialCenter: fields[6] as String?,
      noOfBags: fields[7] as int?,
      lessTare: fields[8] as int?,
      totalWeight: fields[9] as int?,
      netWeight: fields[10] as int?,
      bags: (fields[11] as List?)?.cast<BagsModel>(),
      createdAt: fields[12] as String?,
      updatedAt: fields[13] as String?,
      iV: fields[14] as int?,
      materialCenterText: fields[15] as String?,
      uploaded: fields[18] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, EntryModel obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.sNo)
      ..writeByte(2)
      ..write(obj.mark)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.party)
      ..writeByte(5)
      ..write(obj.ratePerQuintal)
      ..writeByte(6)
      ..write(obj.materialCenter)
      ..writeByte(7)
      ..write(obj.noOfBags)
      ..writeByte(8)
      ..write(obj.lessTare)
      ..writeByte(9)
      ..write(obj.totalWeight)
      ..writeByte(10)
      ..write(obj.netWeight)
      ..writeByte(11)
      ..write(obj.bags)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt)
      ..writeByte(14)
      ..write(obj.iV)
      ..writeByte(15)
      ..write(obj.materialCenterText)
      ..writeByte(16)
      ..write(obj.picture)
      ..writeByte(17)
      ..write(obj.user)
      ..writeByte(18)
      ..write(obj.uploaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PictureAdapter extends TypeAdapter<Picture> {
  @override
  final int typeId = 3;

  @override
  Picture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Picture(
      mediaUrl: fields[0] as String?,
      mediaRef: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Picture obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.mediaUrl)
      ..writeByte(1)
      ..write(obj.mediaRef);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PictureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BagsModelAdapter extends TypeAdapter<BagsModel> {
  @override
  final int typeId = 4;

  @override
  BagsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BagsModel(
      sNo: fields[0] as int?,
      weight: fields[1] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, BagsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sNo)
      ..writeByte(1)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BagsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
