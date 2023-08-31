class LoginRequest {

  String email;
  String password;

  LoginRequest(this.email, this.password);

}

class RegisterRequest {

  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  //String profilePicture;

  RegisterRequest(
    this.userName,
    this.countryMobileCode,
    this.mobileNumber,
    this.email,
    this.password/*,
    this.profilePicture*/
  );

}

class EditRequest {

  String id;
  String name;
  String type;


  EditRequest(
    this.id,
    this.name,
    this.type
  );

}

class AddRequest {

  String userId;
  String name;
  String type;


  AddRequest(
    this.userId,
    this.name,
    this.type
  );

}