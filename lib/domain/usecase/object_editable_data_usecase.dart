import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ObjectEditableDataUseCase implements BaseUseCase<String,MapObjects> {
  
  final Repository _repository;

  ObjectEditableDataUseCase(this._repository);


  @override
  Future<Either<Failure, MapObjects>> execute(String id) async{
    return await _repository.getObjectEditableData(id);    
  }
}