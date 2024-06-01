// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartyModelAdapter extends TypeAdapter<PartyModel> {
  @override
  final int typeId = 1;

  @override
  PartyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PartyModel(
      sId: fields[0] as String?,
      partyName: fields[1] as String?,
      phoneNumber: fields[2] as String?,
      email: fields[3] as String?,
      city: fields[4] as String?,
      createdAt: fields[5] as String?,
      updatedAt: fields[6] as String?,
      iV: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PartyModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.partyName)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.iV);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
