import '../../domain/model/models.dart';
import '../responses/responses.dart';
import 'package:http_course/app/extensions.dart';
import 'package:http_course/app/constants.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numberOfNotification.orZero() ?? Constants.zero);
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension DeleteObjectResponseMapper on DeleteObjectResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension AddObjectResponseMapper on AddObjectResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension EditObjectResponseMapper on EditObjectResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}








extension PositionResponseMapper on PositionResponse? {
  Position toDomain() {
    return Position(this?.long.orZero() ?? Constants.zeroDouble,
        this?.lat.orZero() ?? Constants.zeroDouble);
  }
}

extension OneObjectResponseMapper on OneObjectResponse? {
  OneObject toDomain() {
    return OneObject(
        this?.id.orEmpty() ?? Constants.empty,
        this?.batteryLevel.orZero() ?? Constants.zeroDouble,
        this?.type.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.position.toDomain());
  }
}

extension MapObjectsResponseMapper on MapObjectsResponse? {
  MapObjects toDomain() {
    List<OneObject> objects = (this
                ?.objects
                ?.map((onObjectResponse) => onObjectResponse.toDomain()) ??
            const Iterable.empty())
        .cast<OneObject>()
        .toList();
    return MapObjects(objects);
  }
}



extension ObjectDetailsResponseMapper on ObjectDetailsResponse? {
  ObjectDetails toDomain() {
    return ObjectDetails(
        this?.id.orEmpty() ?? Constants.empty,
        this?.batteryLevel.orZero() ?? Constants.zeroDouble,
        this?.type.orEmpty() ?? Constants.empty,
        this?.createdAt.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.farFromYou.orZero() ?? Constants.zeroDouble,
        this?.position.toDomain());
  }
}













