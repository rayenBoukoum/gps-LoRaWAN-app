
import 'package:dartz/dartz.dart';
import 'package:http_course/data/network/failure.dart';
import 'package:http_course/domain/model/models.dart';

// In data qui vient du view model comme email password
// out data qui revient au usecase du Data layer et on l'envoie au view model 

abstract class BaseUseCase<In,Out> {

  Future<Either<Failure,Out>> execute(In input);

}
