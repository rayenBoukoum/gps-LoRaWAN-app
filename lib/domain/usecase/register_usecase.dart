import 'package:http_course/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http_course/data/network/requests.dart';
import 'package:http_course/domain/model/models.dart';
import 'package:http_course/domain/repository/repository.dart';
import 'package:http_course/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.userName,
        input.countryMobileCode,
        input.mobileNumber,
        input.email,
        input.password
        /*,input.profilePicture*/));
  }
}

class RegisterUseCaseInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  //String profilePicture;

  RegisterUseCaseInput(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password/*, this.profilePicture*/);
}
