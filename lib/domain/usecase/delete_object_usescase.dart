import 'package:http_course/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http_course/domain/repository/repository.dart';
import 'package:http_course/domain/usecase/base_usecase.dart';


class DeleteObjectUseCase implements BaseUseCase<String, String> {
  
  final Repository _repository;

  DeleteObjectUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String input) async { 
    return await _repository.deleteObject(input);
  }
}