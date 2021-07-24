// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tastings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tasting _$TastingFromJson(Map<String, dynamic> json) {
  return Tasting(
    date: DateTime.parse(json['date'] as String),
    beer: Beer.fromJson(json['beer'] as Map<String, dynamic>),
    location: json['location'] as String?,
    beerColour: json['beerColour'] as String?,
    beerColourDesc: json['beerColourDesc'] as String?,
    colourEbc: json['colourEbc'] as int?,
    clarity: json['clarity'] as String?,
    foamColour: json['foamColour'] as String?,
    foamStructure: json['foamStructure'] as String?,
    foamStability: json['foamStability'] as int,
    bitternessRating: json['bitternessRating'] as int,
    sweetnessRating: json['sweetnessRating'] as int,
    acidityRating: json['acidityRating'] as int,
    mouthFeelDesc: json['mouthFeelDesc'] as String?,
    fullBodiedRating: json['fullBodiedRating'] as int,
    bodyDesc: json['bodyDesc'] as String?,
    aftertasteDesc: json['aftertasteDesc'] as String?,
    aftertasteRating: json['aftertasteRating'] as int,
    foodRecommendation: json['foodRecommendation'] as String?,
    totalImpressionDesc: json['totalImpressionDesc'] as String?,
    totalImpressionRating: json['totalImpressionRating'] as int,
  );
}

Map<String, dynamic> _$TastingToJson(Tasting instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'location': instance.location,
      'beer': instance.beer.toJson(),
      'beerColour': instance.beerColour,
      'beerColourDesc': instance.beerColourDesc,
      'colourEbc': instance.colourEbc,
      'clarity': instance.clarity,
      'foamColour': instance.foamColour,
      'foamStructure': instance.foamStructure,
      'foamStability': instance.foamStability,
      'bitternessRating': instance.bitternessRating,
      'sweetnessRating': instance.sweetnessRating,
      'acidityRating': instance.acidityRating,
      'mouthFeelDesc': instance.mouthFeelDesc,
      'fullBodiedRating': instance.fullBodiedRating,
      'bodyDesc': instance.bodyDesc,
      'aftertasteDesc': instance.aftertasteDesc,
      'aftertasteRating': instance.aftertasteRating,
      'foodRecommendation': instance.foodRecommendation,
      'totalImpressionDesc': instance.totalImpressionDesc,
      'totalImpressionRating': instance.totalImpressionRating,
    };
