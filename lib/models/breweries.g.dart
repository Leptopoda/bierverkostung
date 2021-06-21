// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breweries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brewery _$BreweryFromJson(Map<String, dynamic> json) {
  return Brewery(
    breweryName: json['breweryName'] as String,
    breweryLocation: json['breweryLocation'] as String?,
    country: json['country'] as String?,
  );
}

Map<String, dynamic> _$BreweryToJson(Brewery instance) => <String, dynamic>{
      'breweryName': instance.breweryName,
      'breweryLocation': instance.breweryLocation,
      'country': instance.country,
    };
