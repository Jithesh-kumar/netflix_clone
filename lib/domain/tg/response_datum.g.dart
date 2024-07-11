// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseDatum _$ResponseDatumFromJson(Map<String, dynamic> json) =>
    ResponseDatum(
      propertyId: json['property_id'] as String?,
      propName: json['prop_name'] as String?,
      location: json['location'] as String?,
      propPrice: json['prop_price'] as String?,
      propStatus: json['prop_status'] as String?,
      wishlist: json['wishlist'] as String?,
      propType: json['prop_type'] as String?,
      availabilityStatus: json['availability_status'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      propertyInfo: (json['propertyInfo'] as List<dynamic>?)
          ?.map((e) => PropertyInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseDatumToJson(ResponseDatum instance) =>
    <String, dynamic>{
      'property_id': instance.propertyId,
      'prop_name': instance.propName,
      'location': instance.location,
      'prop_price': instance.propPrice,
      'prop_status': instance.propStatus,
      'wishlist': instance.wishlist,
      'prop_type': instance.propType,
      'availability_status': instance.availabilityStatus,
      'image': instance.image,
      'propertyInfo': instance.propertyInfo,
    };

PropertyInfo _$PropertyInfoFromJson(Map<String, dynamic> json) => PropertyInfo(
      specId: json['spec_id'] as String?,
      spec: json['spec'] as String?,
      size: json['size'] as String?,
    );

Map<String, dynamic> _$PropertyInfoToJson(PropertyInfo instance) =>
    <String, dynamic>{
      'spec_id': instance.specId,
      'spec': instance.spec,
      'size': instance.size,
    };

Tg _$TgFromJson(Map<String, dynamic> json) => Tg(
      responseCode: json['responseCode'] as int?,
      responseMessage: json['responseMessage'] as String?,
      responseData: (json['responseData'] as List<dynamic>?)
          ?.map((e) => ResponseDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TgToJson(Tg instance) => <String, dynamic>{
      'responseCode': instance.responseCode,
      'responseMessage': instance.responseMessage,
      'responseData': instance.responseData,
    };
