import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AddObjectUseCase implements BaseUseCase<AddUseCaseInput, String> {
  
  final Repository _repository;

  AddObjectUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(AddUseCaseInput input) async {
    return await _repository.addObject(AddRequest(input.userId, input.name, input.type));
  }
  
}

class AddUseCaseInput {
  
  String userId;
  String name;
  String type;

  AddUseCaseInput(this.userId, this.name, this.type);
}