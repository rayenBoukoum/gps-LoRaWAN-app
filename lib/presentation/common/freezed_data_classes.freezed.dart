// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginObject {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String userName, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_LoginObjectCopyWith(
          _$_LoginObject value, $Res Function(_$_LoginObject) then) =
      __$$_LoginObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, String password});
}

/// @nodoc
class __$$_LoginObjectCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$_LoginObject>
    implements _$$_LoginObjectCopyWith<$Res> {
  __$$_LoginObjectCopyWithImpl(
      _$_LoginObject _value, $Res Function(_$_LoginObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
  }) {
    return _then(_$_LoginObject(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.userName, this.password);

  @override
  final String userName;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(userName: $userName, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginObject &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      __$$_LoginObjectCopyWithImpl<_$_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String userName, final String password) =
      _$_LoginObject;

  @override
  String get userName;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddObject {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddObjectCopyWith<AddObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddObjectCopyWith<$Res> {
  factory $AddObjectCopyWith(AddObject value, $Res Function(AddObject) then) =
      _$AddObjectCopyWithImpl<$Res, AddObject>;
  @useResult
  $Res call({String name, String type});
}

/// @nodoc
class _$AddObjectCopyWithImpl<$Res, $Val extends AddObject>
    implements $AddObjectCopyWith<$Res> {
  _$AddObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddObjectCopyWith<$Res> implements $AddObjectCopyWith<$Res> {
  factory _$$_AddObjectCopyWith(
          _$_AddObject value, $Res Function(_$_AddObject) then) =
      __$$_AddObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String type});
}

/// @nodoc
class __$$_AddObjectCopyWithImpl<$Res>
    extends _$AddObjectCopyWithImpl<$Res, _$_AddObject>
    implements _$$_AddObjectCopyWith<$Res> {
  __$$_AddObjectCopyWithImpl(
      _$_AddObject _value, $Res Function(_$_AddObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_$_AddObject(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AddObject implements _AddObject {
  _$_AddObject(this.name, this.type);

  @override
  final String name;
  @override
  final String type;

  @override
  String toString() {
    return 'AddObject(name: $name, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddObject &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddObjectCopyWith<_$_AddObject> get copyWith =>
      __$$_AddObjectCopyWithImpl<_$_AddObject>(this, _$identity);
}

abstract class _AddObject implements AddObject {
  factory _AddObject(final String name, final String type) = _$_AddObject;

  @override
  String get name;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_AddObjectCopyWith<_$_AddObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RegisterObject {
  String get userName => throw _privateConstructorUsedError;
  String get countryMobileCode => throw _privateConstructorUsedError;
  String get mobileNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get profilePicture => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res, RegisterObject>;
  @useResult
  $Res call(
      {String userName,
      String countryMobileCode,
      String mobileNumber,
      String email,
      String password,
      String profilePicture});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res, $Val extends RegisterObject>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? countryMobileCode = null,
    Object? mobileNumber = null,
    Object? email = null,
    Object? password = null,
    Object? profilePicture = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      countryMobileCode: null == countryMobileCode
          ? _value.countryMobileCode
          : countryMobileCode // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterObjectCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$_RegisterObjectCopyWith(
          _$_RegisterObject value, $Res Function(_$_RegisterObject) then) =
      __$$_RegisterObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userName,
      String countryMobileCode,
      String mobileNumber,
      String email,
      String password,
      String profilePicture});
}

/// @nodoc
class __$$_RegisterObjectCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res, _$_RegisterObject>
    implements _$$_RegisterObjectCopyWith<$Res> {
  __$$_RegisterObjectCopyWithImpl(
      _$_RegisterObject _value, $Res Function(_$_RegisterObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? countryMobileCode = null,
    Object? mobileNumber = null,
    Object? email = null,
    Object? password = null,
    Object? profilePicture = null,
  }) {
    return _then(_$_RegisterObject(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == countryMobileCode
          ? _value.countryMobileCode
          : countryMobileCode // ignore: cast_nullable_to_non_nullable
              as String,
      null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RegisterObject implements _RegisterObject {
  _$_RegisterObject(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password, this.profilePicture);

  @override
  final String userName;
  @override
  final String countryMobileCode;
  @override
  final String mobileNumber;
  @override
  final String email;
  @override
  final String password;
  @override
  final String profilePicture;

  @override
  String toString() {
    return 'RegisterObject(userName: $userName, countryMobileCode: $countryMobileCode, mobileNumber: $mobileNumber, email: $email, password: $password, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterObject &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.countryMobileCode, countryMobileCode) ||
                other.countryMobileCode == countryMobileCode) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, countryMobileCode,
      mobileNumber, email, password, profilePicture);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterObjectCopyWith<_$_RegisterObject> get copyWith =>
      __$$_RegisterObjectCopyWithImpl<_$_RegisterObject>(this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(
      final String userName,
      final String countryMobileCode,
      final String mobileNumber,
      final String email,
      final String password,
      final String profilePicture) = _$_RegisterObject;

  @override
  String get userName;
  @override
  String get countryMobileCode;
  @override
  String get mobileNumber;
  @override
  String get email;
  @override
  String get password;
  @override
  String get profilePicture;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterObjectCopyWith<_$_RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DetailObject {
  String get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DetailObjectCopyWith<DetailObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailObjectCopyWith<$Res> {
  factory $DetailObjectCopyWith(
          DetailObject value, $Res Function(DetailObject) then) =
      _$DetailObjectCopyWithImpl<$Res, DetailObject>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$DetailObjectCopyWithImpl<$Res, $Val extends DetailObject>
    implements $DetailObjectCopyWith<$Res> {
  _$DetailObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DetailObjectCopyWith<$Res>
    implements $DetailObjectCopyWith<$Res> {
  factory _$$_DetailObjectCopyWith(
          _$_DetailObject value, $Res Function(_$_DetailObject) then) =
      __$$_DetailObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$_DetailObjectCopyWithImpl<$Res>
    extends _$DetailObjectCopyWithImpl<$Res, _$_DetailObject>
    implements _$$_DetailObjectCopyWith<$Res> {
  __$$_DetailObjectCopyWithImpl(
      _$_DetailObject _value, $Res Function(_$_DetailObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$_DetailObject(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_DetailObject implements _DetailObject {
  _$_DetailObject(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'DetailObject(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetailObject &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetailObjectCopyWith<_$_DetailObject> get copyWith =>
      __$$_DetailObjectCopyWithImpl<_$_DetailObject>(this, _$identity);
}

abstract class _DetailObject implements DetailObject {
  factory _DetailObject(final String id) = _$_DetailObject;

  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_DetailObjectCopyWith<_$_DetailObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SortableObject {
  bool get getListOfKids => throw _privateConstructorUsedError;
  bool get getListOfPets => throw _privateConstructorUsedError;
  bool get getListOfCars => throw _privateConstructorUsedError;
  String get searchWithWord => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SortableObjectCopyWith<SortableObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortableObjectCopyWith<$Res> {
  factory $SortableObjectCopyWith(
          SortableObject value, $Res Function(SortableObject) then) =
      _$SortableObjectCopyWithImpl<$Res, SortableObject>;
  @useResult
  $Res call(
      {bool getListOfKids,
      bool getListOfPets,
      bool getListOfCars,
      String searchWithWord});
}

/// @nodoc
class _$SortableObjectCopyWithImpl<$Res, $Val extends SortableObject>
    implements $SortableObjectCopyWith<$Res> {
  _$SortableObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getListOfKids = null,
    Object? getListOfPets = null,
    Object? getListOfCars = null,
    Object? searchWithWord = null,
  }) {
    return _then(_value.copyWith(
      getListOfKids: null == getListOfKids
          ? _value.getListOfKids
          : getListOfKids // ignore: cast_nullable_to_non_nullable
              as bool,
      getListOfPets: null == getListOfPets
          ? _value.getListOfPets
          : getListOfPets // ignore: cast_nullable_to_non_nullable
              as bool,
      getListOfCars: null == getListOfCars
          ? _value.getListOfCars
          : getListOfCars // ignore: cast_nullable_to_non_nullable
              as bool,
      searchWithWord: null == searchWithWord
          ? _value.searchWithWord
          : searchWithWord // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SortableObjectCopyWith<$Res>
    implements $SortableObjectCopyWith<$Res> {
  factory _$$_SortableObjectCopyWith(
          _$_SortableObject value, $Res Function(_$_SortableObject) then) =
      __$$_SortableObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool getListOfKids,
      bool getListOfPets,
      bool getListOfCars,
      String searchWithWord});
}

/// @nodoc
class __$$_SortableObjectCopyWithImpl<$Res>
    extends _$SortableObjectCopyWithImpl<$Res, _$_SortableObject>
    implements _$$_SortableObjectCopyWith<$Res> {
  __$$_SortableObjectCopyWithImpl(
      _$_SortableObject _value, $Res Function(_$_SortableObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? getListOfKids = null,
    Object? getListOfPets = null,
    Object? getListOfCars = null,
    Object? searchWithWord = null,
  }) {
    return _then(_$_SortableObject(
      null == getListOfKids
          ? _value.getListOfKids
          : getListOfKids // ignore: cast_nullable_to_non_nullable
              as bool,
      null == getListOfPets
          ? _value.getListOfPets
          : getListOfPets // ignore: cast_nullable_to_non_nullable
              as bool,
      null == getListOfCars
          ? _value.getListOfCars
          : getListOfCars // ignore: cast_nullable_to_non_nullable
              as bool,
      null == searchWithWord
          ? _value.searchWithWord
          : searchWithWord // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SortableObject implements _SortableObject {
  _$_SortableObject(this.getListOfKids, this.getListOfPets, this.getListOfCars,
      this.searchWithWord);

  @override
  final bool getListOfKids;
  @override
  final bool getListOfPets;
  @override
  final bool getListOfCars;
  @override
  final String searchWithWord;

  @override
  String toString() {
    return 'SortableObject(getListOfKids: $getListOfKids, getListOfPets: $getListOfPets, getListOfCars: $getListOfCars, searchWithWord: $searchWithWord)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SortableObject &&
            (identical(other.getListOfKids, getListOfKids) ||
                other.getListOfKids == getListOfKids) &&
            (identical(other.getListOfPets, getListOfPets) ||
                other.getListOfPets == getListOfPets) &&
            (identical(other.getListOfCars, getListOfCars) ||
                other.getListOfCars == getListOfCars) &&
            (identical(other.searchWithWord, searchWithWord) ||
                other.searchWithWord == searchWithWord));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, getListOfKids, getListOfPets, getListOfCars, searchWithWord);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SortableObjectCopyWith<_$_SortableObject> get copyWith =>
      __$$_SortableObjectCopyWithImpl<_$_SortableObject>(this, _$identity);
}

abstract class _SortableObject implements SortableObject {
  factory _SortableObject(
      final bool getListOfKids,
      final bool getListOfPets,
      final bool getListOfCars,
      final String searchWithWord) = _$_SortableObject;

  @override
  bool get getListOfKids;
  @override
  bool get getListOfPets;
  @override
  bool get getListOfCars;
  @override
  String get searchWithWord;
  @override
  @JsonKey(ignore: true)
  _$$_SortableObjectCopyWith<_$_SortableObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EditObject {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditObjectCopyWith<EditObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditObjectCopyWith<$Res> {
  factory $EditObjectCopyWith(
          EditObject value, $Res Function(EditObject) then) =
      _$EditObjectCopyWithImpl<$Res, EditObject>;
  @useResult
  $Res call({String id, String name, String type});
}

/// @nodoc
class _$EditObjectCopyWithImpl<$Res, $Val extends EditObject>
    implements $EditObjectCopyWith<$Res> {
  _$EditObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditObjectCopyWith<$Res>
    implements $EditObjectCopyWith<$Res> {
  factory _$$_EditObjectCopyWith(
          _$_EditObject value, $Res Function(_$_EditObject) then) =
      __$$_EditObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String type});
}

/// @nodoc
class __$$_EditObjectCopyWithImpl<$Res>
    extends _$EditObjectCopyWithImpl<$Res, _$_EditObject>
    implements _$$_EditObjectCopyWith<$Res> {
  __$$_EditObjectCopyWithImpl(
      _$_EditObject _value, $Res Function(_$_EditObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_$_EditObject(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_EditObject implements _EditObject {
  _$_EditObject(this.id, this.name, this.type);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;

  @override
  String toString() {
    return 'EditObject(id: $id, name: $name, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditObject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditObjectCopyWith<_$_EditObject> get copyWith =>
      __$$_EditObjectCopyWithImpl<_$_EditObject>(this, _$identity);
}

abstract class _EditObject implements EditObject {
  factory _EditObject(final String id, final String name, final String type) =
      _$_EditObject;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_EditObjectCopyWith<_$_EditObject> get copyWith =>
      throw _privateConstructorUsedError;
}
