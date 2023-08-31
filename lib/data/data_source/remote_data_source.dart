import 'package:http_course/data/network/app_api.dart';
import 'package:http_course/data/network/requests.dart';
import 'package:http_course/data/responses/responses.dart';

abstract class RemoteDataSource {
  
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);


  Future<MapObjectsResponse> getDashData(String id);
  Future<MapObjectsResponse> getMapData(String id);
  Future<MapObjectsResponse> getObjectEditableData(String id);
  Future<MapObjectsResponse> getMapData2(String id);



  Future<ObjectDetailsResponse> getObjectDetails(String id);
  Future<DeleteObjectResponse> deleteObject(String id);
  Future<AddObjectResponse> addObject(AddRequest addRequest);
  Future<EditObjectResponse> editObject(EditRequest editRequest);

}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password//,
        /*registerRequest.profilePicture*/ );
  }
  

  
  @override
  Future<MapObjectsResponse> getMapData(String id) async{
    return await _appServiceClient.getMapData(id);
   
  }


  
  @override
  Future<ObjectDetailsResponse> getObjectDetails(String id) async{
    return await _appServiceClient.getObjectDetails(id);
  }
  
  @override
  Future<MapObjectsResponse> getMapData2(String id) async{
    return await _appServiceClient.getMapData2(id);
  }


  
  @override
  Future<MapObjectsResponse> getDashData(String id) async{
    return await _appServiceClient.getDashData(id);
  }
  
  @override
  Future<MapObjectsResponse> getObjectEditableData(String id) async{
    return await _appServiceClient.getObjectEditableData(id);
  }
  
  @override
  Future<DeleteObjectResponse> deleteObject(String id) async{
    return await _appServiceClient.deleteObject(id);
  }
  
  @override
  Future<EditObjectResponse> editObject(EditRequest editRequest) async{
    return await _appServiceClient.editObject(editRequest.id, editRequest.name, editRequest.type);
  }
  
  @override
  Future<AddObjectResponse> addObject(AddRequest addRequest) async{
    return await _appServiceClient.addObject(addRequest.userId, addRequest.name, addRequest.type);
  }
  



}
