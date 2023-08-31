import 'package:freezed_annotation/freezed_annotation.dart';


part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class AddObject with _$AddObject {
  factory AddObject(String name, String type) = _AddObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String userName,
      String countryMobileCode,
      String mobileNumber,
      String email,
      String password,
      String profilePicture) = _RegisterObject;
}

@freezed
class DetailObject with _$DetailObject {
  factory DetailObject(String id) = _DetailObject;
}

@freezed
class SortableObject with _$SortableObject {

    factory SortableObject(
      bool getListOfKids,
      bool getListOfPets,
      bool getListOfCars,
      String searchWithWord,
      ) = _SortableObject;
}

@freezed
class EditObject with _$EditObject {
  factory EditObject(
      String id,
      String name,
      String type) = _EditObject;
}