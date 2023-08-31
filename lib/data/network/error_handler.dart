import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http_course/data/network/failure.dart';

import '../../presentation/ressources/strings_manager.dart';


class ErrorHandler implements Exception{

  late Failure failure;

  ErrorHandler.handel(dynamic error) {
    if(error is DioError) {
      // dio error so its error from response of the API or fro dio itself
      failure = _handelError(error);
      
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }

}


Failure _handelError(DioError error) {
  
  switch(error.type) {
    case DioErrorType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioErrorType.badCertificate:
      if(error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0, error.response?.statusMessage ?? '');
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.badResponse:
      if(error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0, error.response?.statusMessage ?? '');
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.connectionError:
      if(error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0, error.response?.statusMessage ?? '');
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioErrorType.unknown:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {

  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDEN,
  UNAUTHRISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT

}



extension DataSourceExtension on DataSource {

  Failure getFailure() {

    switch(this){
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDEN:
        return Failure(ResponseCode.FORBIDEN, ResponseMessage.FORBIDEN);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.UNAUTHRISED:
        return Failure(ResponseCode.UNAUTHRISED, ResponseMessage.UNAUTHRISED);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT); 
    }

}
}

class ResponseCode {

  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int FORBIDEN = 403; // failure, API rejected request
  static const int UNAUTHRISED = 401; // failure, user in not authorised
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code 
  static const int CONNECT_TIMEOUT = -1; 
  static const int CANCEL = -2; 
  static const int RECIEVE_TIMEOUT = -3; 
  static const int SEND_TIMEOUT = -4; 
  static const int CACHE_ERROR = -5; 
  static const int NO_INTERNET_CONNECTION = -6; 
  static const int DEFAULT = -7; 
}

class ResponseMessage {

  static  String SUCCESS = AppStrings.successResponse.tr(); // success with data
  static  String NO_CONTENT = AppStrings.noContent.tr(); // success with no data (no content)
  static  String BAD_REQUEST = AppStrings.badRequest.tr(); // failure, API rejected request
  static  String FORBIDEN = AppStrings.forbiden.tr(); // failure, API rejected request
  static  String UNAUTHRISED = AppStrings.unauthorised.tr(); // failure, user in not authorised
  static  String INTERNAL_SERVER_ERROR = AppStrings.internalServerError.tr(); // failure, crash in server side
  static  String NOT_FOUND= AppStrings.notFound.tr(); // failure, crash in server side

  // local status code 
  static  String CONNECT_TIMEOUT = AppStrings.connectTimeOut.tr(); 
  static  String CANCEL = AppStrings.cancel.tr(); 
  static  String RECIEVE_TIMEOUT = AppStrings.receiveTimeout.tr(); 
  static  String SEND_TIMEOUT = AppStrings.sendTimeOut.tr(); 
  static  String CACHE_ERROR = AppStrings.cacheError.tr(); 
  static  String NO_INTERNET_CONNECTION = AppStrings.noInternetConnection.tr(); 
  static  String WRONG_DATA = AppStrings.wrongData.tr(); 
  static  String DEFAULT = AppStrings.defaultResponse.tr(); 
}

class ApiInternalStatus {

  static const int SUCCESS = 0;
  static const int FAILURE = 1;

}