// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beer _$BeerFromJson(Map<String, dynamic> json) {
  return Beer(
    beerName: json['beerName'] as String,
    brewery: json['brewery'] == null
        ? null
        : Brewery.fromJson(json['brewery'] as Map<String, dynamic>),
    style: json['style'] as String?,
    originalWort: (json['originalWort'] as num?)?.toDouble(),
    alcohol: (json['alcohol'] as num?)?.toDouble(),
    ibu: json['ibu'] as int?,
    ingredients: json['ingredients'] as String?,
    specifics: json['specifics'] as String?,
    beerNotes: json['beerNotes'] as String?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$BeerToJson(Beer instance) => <String, dynamic>{
      'beerName': instance.beerName,
      'brewery': instance.brewery?.toJson(),
      'style': instance.style,
      'originalWort': instance.originalWort,
      'alcohol': instance.alcohol,
      'ibu': instance.ibu,
      'ingredients': instance.ingredients,
      'specifics': instance.specifics,
      'beerNotes': instance.beerNotes,
      'images': instance.images,
    };
