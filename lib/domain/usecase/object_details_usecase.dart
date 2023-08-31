import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ObjectDetailsUseCase extends BaseUseCase<String, ObjectDetails> {
  Repository repository;

  ObjectDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ObjectDetails>> execute(String input) {
    return repository.getObjectDetails(input);
  }
}