import 'package:dartz/dartz.dart';
import 'package:http_course/data/network/requests.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class EditObjectUseCase implements BaseUseCase<EditUsesCaseInput, String> {
  
  final Repository _repository;

  EditObjectUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(EditUsesCaseInput input) async {
    return await _repository.editObject(EditRequest(input.id, input.name, input.type));
  }
  
}

class EditUsesCaseInput {
  
  String id;
  String name;
  String type;


  EditUsesCaseInput(this.id, this.name, this.type);
}