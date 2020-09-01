// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 3;

  @override
  User read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      name: fields[2] as String,
      email: fields[3] as String,
      userImg: fields[4] as String,
      mobile: fields[1] as String,
      address: fields[5] as String,
      firstName: fields[6] as String,
      lastName: fields[7] as String,
      countryCode: fields[8] as String,
      countryId: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mobile)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.userImg)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.firstName)
      ..writeByte(7)
      ..write(obj.lastName)
      ..writeByte(8)
      ..write(obj.countryCode)
      ..writeByte(9)
      ..write(obj.countryId);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String ?? '',
    email: json['email'] as String ?? '',
    userImg: json['user_img'] as String ?? '',
    mobile: json['mobile'] as String,
    address: json['address'] as String ?? '',
    firstName: json['fname'] as String ?? '',
    lastName: json['lname'] as String ?? '',
    countryCode: json['country_code'] as String ?? '',
    countryId: json['country_id'] as int ?? 0,
    isNew: json['is_new'] as int ?? 0,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'mobile': instance.mobile,
      'name': instance.name,
      'email': instance.email,
      'user_img': instance.userImg,
      'address': instance.address,
      'fname': instance.firstName,
      'lname': instance.lastName,
      'country_code': instance.countryCode,
      'country_id': instance.countryId,
      'is_new': instance.isNew,
    };
