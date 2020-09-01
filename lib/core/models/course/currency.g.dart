// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyAdapter extends TypeAdapter<Currency> {
  @override
  final int typeId = 25;

  @override
  Currency read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Currency(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Currency obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.symbol);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return Currency(
    json['currency'] as String,
    json['symbol'] as String,
  );
}

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'currency': instance.currency,
      'symbol': instance.symbol,
    };
