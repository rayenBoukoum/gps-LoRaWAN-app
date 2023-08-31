
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {

  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "message")
  String? message;

}

@JsonSerializable()
class CustomerResponse {

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "numberOfNotification")
  int? numberOfNotification;

  CustomerResponse(this.id, this.name, this.numberOfNotification);

  // from json
  factory CustomerResponse.fromJson(Map<String,dynamic> json) => _$CustomerResponseFromJson(json);
  
  // to json
  Map<String,dynamic> toJson() => _$CustomerResponseToJson(this);

}

@JsonSerializable()
class ContactResponse {

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "link")
  String? link;

  ContactResponse(this.phone, this.email, this.link);

    // from json
  factory ContactResponse.fromJson(Map<String,dynamic> json) => _$ContactResponseFromJson(json);
  
  // to json
  Map<String,dynamic> toJson() => _$ContactResponseToJson(this);

}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  
  @JsonKey(name: "customer")
  CustomerResponse? customer;

  @JsonKey(name: "contacts")
  ContactResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts);

  // from json
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json) => _$AuthenticationResponseFromJson(json);
  
  // to json
  Map<String,dynamic> toJson() => _$AuthenticationResponseToJson(this);

}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {

  @JsonKey(name: "support")
  String? support;

  ForgotPasswordResponse(this.support);

  // from json
  factory ForgotPasswordResponse.fromJson(Map<String,dynamic> json) => _$ForgotPasswordResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() => _$ForgotPasswordResponseToJson(this);

}


@JsonSerializable()
class DeleteObjectResponse extends BaseResponse {

  @JsonKey(name: "support")
  String? support;

  DeleteObjectResponse(this.support);

  // from json
  factory DeleteObjectResponse.fromJson(Map<String,dynamic> json) => _$DeleteObjectResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() => _$DeleteObjectResponseToJson(this);

}

@JsonSerializable()
class AddObjectResponse extends BaseResponse {

  @JsonKey(name: "support")
  String? support;

  AddObjectResponse(this.support);

  // from json
  factory AddObjectResponse.fromJson(Map<String,dynamic> json) => _$AddObjectResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() => _$AddObjectResponseToJson(this);

}


@JsonSerializable()
class EditObjectResponse extends BaseResponse {

  @JsonKey(name: "support")
  String? support;

  EditObjectResponse(this.support);

  // from json
  factory EditObjectResponse.fromJson(Map<String,dynamic> json) => _$EditObjectResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() => _$EditObjectResponseToJson(this);

}


@JsonSerializable()
class PositionResponse {

  @JsonKey(name: "long")
  double? long;

  @JsonKey(name: "lat")
  double? lat;

  PositionResponse(this.long, this.lat);

  // from json
  factory PositionResponse.fromJson(Map<String,dynamic> json) => _$PositionResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() => _$PositionResponseToJson(this);

}

@JsonSerializable()
class OneObjectResponse {

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "batteryLevel")
  double? batteryLevel;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "position")
  PositionResponse? position;

  OneObjectResponse(this.id, this.batteryLevel, this.type, this.name, this.position);

  // from json
  factory OneObjectResponse.fromJson(Map<String,dynamic> json) => _$OneObjectResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() => _$OneObjectResponseToJson(this);

}

@JsonSerializable()
class MapObjectsResponse extends BaseResponse {

  @JsonKey(name: "objects")
  List<OneObjectResponse>? objects;

  MapObjectsResponse(this.objects);

  // from json
  factory MapObjectsResponse.fromJson(Map<String,dynamic> json) => _$MapObjectsResponseFromJson(json);

  // to json
  Map<String,dynamic> toJson() => _$MapObjectsResponseToJson(this);

}





@JsonSerializable()
class ObjectDetailsResponse extends BaseResponse{

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "batteryLevel")
  double? batteryLevel;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "createdAt")
  String? createdAt;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "farFromYou")
  double? farFromYou;

  @JsonKey(name: "position")
  PositionResponse? position;

  ObjectDetailsResponse(this.id, this.batteryLevel, this.type, this.createdAt, this.name, this.farFromYou, this.position);

  factory ObjectDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ObjectDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectDetailsResponseToJson(this);
}




