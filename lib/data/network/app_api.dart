import 'package:dio/dio.dart';
import 'package:http_course/data/responses/responses.dart';
import 'package:retrofit/http.dart';

import '../../app/Constants.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {

  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(@Field("email") String email, @Field("password") String password);

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(@Field("email") String email);

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
      @Field("user_name") String userName,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      /*@Field("profile_picture") String profilePicture*/
  );

  @GET("/object")
  Future<MapObjectsResponse> getDashData(@Field("id") String id); 

  @GET("/object")
  Future<MapObjectsResponse> getMapData(@Field("id") String id); 

  @GET("/object")
  Future<MapObjectsResponse> getMapData2(@Field("id") String id);


  @GET("/object")
  Future<MapObjectsResponse> getObjectEditableData(@Field("id") String id);



  //@GET("/objectDetails/1")
  @GET("/object/detail")
  Future<ObjectDetailsResponse> getObjectDetails(@Field("id") String id);

 
  @DELETE("/object/delete")
  Future<DeleteObjectResponse> deleteObject(@Field("id") String id);

  @POST("/object/add")
  Future<AddObjectResponse> addObject(@Field("userId") String userId, @Field("name") String name, @Field("type") String type);


  @PUT("/object/edit")
  Future<EditObjectResponse> editObject(
      @Field("id") String id,
      @Field("name") String name,
      @Field("type") String type
  );

}
