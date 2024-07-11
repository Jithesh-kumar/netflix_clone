import 'package:json_annotation/json_annotation.dart';

part 'response_datum.g.dart';

@JsonSerializable()
class ResponseDatum {
  @JsonKey(name: 'property_id')
  String? propertyId;
  @JsonKey(name: 'prop_name')
  String? propName;
  String? location;
  @JsonKey(name: 'prop_price')
  String? propPrice;
  @JsonKey(name: 'prop_status')
  String? propStatus;
  String? wishlist;
  @JsonKey(name: 'prop_type')
  String? propType;
  @JsonKey(name: 'availability_status')
  String? availabilityStatus;
  List<String>? image;
  List<PropertyInfo>? propertyInfo;

  ResponseDatum({
    this.propertyId,
    this.propName,
    this.location,
    this.propPrice,
    this.propStatus,
    this.wishlist,
    this.propType,
    this.availabilityStatus,
    this.image,
    this.propertyInfo,
  });

  factory ResponseDatum.fromJson(Map<String, dynamic> json) {
    return _$ResponseDatumFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResponseDatumToJson(this);
}

@JsonSerializable()
class PropertyInfo {
  @JsonKey(name: 'spec_id')
  String? specId;
  String? spec;
  String? size;

  PropertyInfo({this.specId, this.spec, this.size});

  factory PropertyInfo.fromJson(Map<String, dynamic> json) {
    return _$PropertyInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PropertyInfoToJson(this);
}

@JsonSerializable()
class Tg {
  int? responseCode;
  String? responseMessage;
  List<ResponseDatum>? responseData;

  Tg({this.responseCode, this.responseMessage, this.responseData});

  factory Tg.fromJson(Map<String, dynamic> json) => _$TgFromJson(json);

  Map<String, dynamic> toJson() => _$TgToJson(this);
}
