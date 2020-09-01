// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_banner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryBannerAdapter extends TypeAdapter<CategoryBanner> {
  @override
  final int typeId = 0;

  @override
  CategoryBanner read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryBanner(
      (fields[0] as List)?.cast<MainCategory>(),
      (fields[42] as List)?.cast<Slider>(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryBanner obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categories)
      ..writeByte(42)
      ..write(obj.sliders);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryBanner _$CategoryBannerFromJson(Map<String, dynamic> json) {
  return CategoryBanner(
    (json['categories'] as List)?.map((e) => e == null ? null : MainCategory.fromJson(e as Map<String, dynamic>))?.toList(),
    (json['sliders'] as List)?.map((e) => e == null ? null : Slider.fromJson(e as Map<String, dynamic>))?.toList(),
  );
}

Map<String, dynamic> _$CategoryBannerToJson(CategoryBanner instance) => <String, dynamic>{
      'categories': instance.categories?.map((e) => e?.toJson())?.toList(),
      'sliders': instance.sliders?.map((e) => e?.toJson())?.toList(),
    };
