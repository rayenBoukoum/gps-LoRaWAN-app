import 'package:http_course/data/network/requests.dart';
import 'package:http_course/data/responses/responses.dart';
import 'package:http_course/domain/model/models.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';

abstract class Repository {

  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);  
  Future<Either<Failure,String>> forgotPassword(String email);
  Future<Either<Failure,Authentication>> register(RegisterRequest registerRequest);  




  Future<Either<Failure,MapObjects>> getDashData(String id);  
  Future<Either<Failure,MapObjects>> getMapData(String id);  
  Future<Either<Failure,MapObjects>> getObjectEditableData(String id);    
  Future<Either<Failure,MapObjects>> getMapData2(String id);  



  Future<Either<Failure, ObjectDetails>> getObjectDetails(String id);
  Future<Either<Failure,String>> deleteObject(String id);
  Future<Either<Failure,String>> addObject(AddRequest addRequest);
  Future<Either<Failure,String>> editObject(EditRequest editRequest);

}