import 'package:http_course/data/data_source/remote_data_source.dart';
import 'package:http_course/data/data_source/local_data_source.dart';
import 'package:http_course/data/mapper/mapper.dart';
import 'package:http_course/data/network/network_info.dart';
import 'package:http_course/domain/model/models.dart';
import 'package:http_course/data/network/requests.dart';
import 'package:http_course/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http_course/domain/repository/repository.dart';

import '../network/error_handler.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure -- return business error
          // return either left
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handel(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
        } else {
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handel(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure -- return business error
          // return either left
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handel(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }



  @override
  Future<Either<Failure, MapObjects>> getMapData(String id) async {
    try {
      // get response from cache
      final response = await _localDataSource.getMapObjectData(); 
      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not existing or cache is not valid
      // its the time to get from API side
      if (await _networkInfo.isConnected) {
        // its connected to internet, its safe to call API
        try {
          final response = await _remoteDataSource.getMapData(id);
          if (response.status == ApiInternalStatus.SUCCESS) {
            //success
            // return either right
            // return data
            // save response in cache  (local data source)
            _localDataSource.saveMapObjectDataToCache(response);
            return Right(response.toDomain());
          } else {
            // failure -- return business error
            // return either left
            return left(Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return left(ErrorHandler.handel(error).failure);
        }
      } else {
        // return internet connection error
        // return either left
        return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }



  @override
  Future<Either<Failure, ObjectDetails>> getObjectDetails(String id) async {
    try {
      // get data from cache

      final response = await _localDataSource.getObjectDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getObjectDetails(id);
          if (response.status == ApiInternalStatus.SUCCESS) {
            _localDataSource.saveObjectDetailsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(response.status ?? ResponseCode.DEFAULT,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handel(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
  



  @override
  Future<Either<Failure, MapObjects>> getMapData2(String id) async{
    try {
      // get response from cache
      final response = await _localDataSource.getMapObjectData2(); 
      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not existing or cache is not valid
      // its the time to get from API side
      if (await _networkInfo.isConnected) {
        // its connected to internet, its safe to call API
        try {
          final response = await _remoteDataSource.getMapData2(id);
          if (response.status == ApiInternalStatus.SUCCESS) {
            //success
            // return either right
            // return data
            // save response in cache  (local data source)
            _localDataSource.saveMapObjectDataToCache2(response);
            return Right(response.toDomain());
          } else {
            // failure -- return business error
            // return either left
            return left(Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return left(ErrorHandler.handel(error).failure);
        }
      } else {
        // return internet connection error
        // return either left
        return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

   
  
  @override
  Future<Either<Failure, MapObjects>> getDashData(String id) async{
    try {
      // get response from cache
      final response = await _localDataSource.getDashData(); 
      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not existing or cache is not valid
      // its the time to get from API side
      if (await _networkInfo.isConnected) {
        // its connected to internet, its safe to call API
        try {
          final response = await _remoteDataSource.getDashData(id);
          if (response.status == ApiInternalStatus.SUCCESS) {
            //success
            // return either right
            // return data
            // save response in cache  (local data source)
            _localDataSource.saveDashDataToCache(response);
            return Right(response.toDomain());
          } else {
            // failure -- return business error
            // return either left
            return left(Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return left(ErrorHandler.handel(error).failure);
        }
      } else {
        // return internet connection error
        // return either left
        return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
  
  @override
  Future<Either<Failure, MapObjects>> getObjectEditableData(String id) async{
      try {
      // get response from cache
      final response = await _localDataSource.getObjectEditableData(); 
      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not existing or cache is not valid
      // its the time to get from API side
      if (await _networkInfo.isConnected) {
        // its connected to internet, its safe to call API
        try {
          final response = await _remoteDataSource.getObjectEditableData(id);
          if (response.status == ApiInternalStatus.SUCCESS) {
            //success
            // return either right
            // return data
            // save response in cache  (local data source)
            _localDataSource.saveObjectEditableDataToCache(response);
            return Right(response.toDomain());
          } else {
            // failure -- return business error
            // return either left
            return left(Failure(ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return left(ErrorHandler.handel(error).failure);
        }
      } else {
        // return internet connection error
        // return either left
        return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
  
  @override
  Future<Either<Failure, String>> deleteObject(String id) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.deleteObject(id);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
        } else {
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handel(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, String>> editObject(EditRequest editRequest) async{
      if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.editObject(editRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
        } else {
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handel(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, String>> addObject(AddRequest addRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addObject(addRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          return right(response.toDomain());
        } else {
          return left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handel(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  

}
