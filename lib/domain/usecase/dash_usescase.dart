import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class DashUseCase implements BaseUseCase<String,MapObjects> {
  
  final Repository _repository;

  DashUseCase(this._repository);


  @override
  Future<Either<Failure, MapObjects>> execute(String id) async{
    return await _repository.getDashData(id);   
  }

}