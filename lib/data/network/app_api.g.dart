// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AppServiceClient implements AppServiceClient {
  _AppServiceClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthenticationResponse> login(
    email,
    password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/customers/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgotPasswordResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/customers/forgotPassword',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgotPasswordResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationResponse> register(
    userName,
    countryMobileCode,
    mobileNumber,
    email,
    password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'user_name': userName,
      'country_mobile_code': countryMobileCode,
      'mobile_number': mobileNumber,
      'email': email,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/customers/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MapObjectsResponse> getDashData(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MapObjectsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/object',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MapObjectsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MapObjectsResponse> getMapData(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MapObjectsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/object',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MapObjectsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MapObjectsResponse> getMapData2(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MapObjectsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/object',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MapObjectsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MapObjectsResponse> getObjectEditableData(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<MapObjectsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/object',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MapObjectsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ObjectDetailsResponse> getObjectDetails(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ObjectDetailsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/object/detail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ObjectDetailsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteObjectResponse> deleteObject(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'id': id};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteObjectResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/object/delete',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteObjectResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddObjectResponse> addObject(
    userId,
    name,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'userId': userId,
      'name': name,
      'type': type,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AddObjectResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/object/add',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddObjectResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EditObjectResponse> editObject(
    id,
    name,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'id': id,
      'name': name,
      'type': type,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<EditObjectResponse>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/object/edit',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EditObjectResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
