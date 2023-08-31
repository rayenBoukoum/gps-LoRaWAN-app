import 'package:http_course/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http_course/domain/model/models.dart';
import 'package:http_course/domain/repository/repository.dart';
import 'package:http_course/domain/usecase/base_usecase.dart';


class MapUseCase implements BaseUseCase<String,MapObjects> {
  
  final Repository _repository;

  MapUseCase(this._repository);


  @override
  Future<Either<Failure, MapObjects>> execute(String id) async{
    return await _repository.getMapData(id);   
  }

}
