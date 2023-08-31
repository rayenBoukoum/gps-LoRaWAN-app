import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_course/app/app_prefs.dart';
import 'package:http_course/data/data_source/local_data_source.dart';
import 'package:http_course/data/data_source/remote_data_source.dart';
import 'package:http_course/data/network/app_api.dart';
import 'package:http_course/data/network/dio_factory.dart';
import 'package:http_course/data/network/network_info.dart';
import 'package:http_course/data/repository/repository_impl.dart';
import 'package:http_course/domain/repository/repository.dart';
import 'package:http_course/domain/usecase/dash_usescase.dart';
import 'package:http_course/domain/usecase/login_usecase.dart';
import 'package:http_course/domain/usecase/map_usecase2.dart';
import 'package:http_course/domain/usecase/map_usescase.dart';
import 'package:http_course/domain/usecase/register_usecase.dart';
import 'package:http_course/presentation/Login/viewModel/login_viewmodel.dart';
import 'package:http_course/presentation/main/pages/search/viewmodel/search_viewmodel.dart';
import 'package:http_course/presentation/main/pages/notifications/viewModel/notfication_viewMode.dart';
import 'package:http_course/presentation/objectDetail/viewModel/object_detail_viewmodel.dart';
import 'package:http_course/presentation/register/viewModel/register_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/add_object_usescase.dart';
import '../domain/usecase/delete_object_usesCase.dart';
import '../domain/usecase/edit_object_usescase.dart';
import '../domain/usecase/forgot_password_usecase.dart';
import '../domain/usecase/object_details_usecase.dart';
import '../domain/usecase/object_editable_data_usecase.dart';
import '../presentation/Delete/viewModel/edit_viewModel.dart';
import '../presentation/addObject/viewModel/add_object_viewmodel.dart';
import '../presentation/edit/viewModel/edit_formulaire_viewmodel.dart';
import '../presentation/forgetPassword/viewModel/forgot_password_viewmodel.dart';

import '../presentation/main/pages/map/viewmodel/map_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic di

  // shared predfs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client instance
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  // local data source instance
  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl());

  // repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() {
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}



initSearchModule() {
  if (!GetIt.I.isRegistered<MapUseCase>()) {
    instance.registerFactory<MapUseCase>(() => MapUseCase(instance()));
    instance.registerFactory<SearchViewModel>(() => SearchViewModel(instance())); 
  }
}

initMapModule() {
  if (!GetIt.I.isRegistered<MapUseCase2>()) {
    instance.registerFactory<MapUseCase2>(() => MapUseCase2(instance()));
    instance.registerFactory<MapViewModel>(() => MapViewModel(instance())); 
  }
}

initAddObjectModule() {
  if (!GetIt.I.isRegistered<AddObjectUseCase>()) {
    instance.registerFactory<AddObjectUseCase>(() => AddObjectUseCase(instance()));
    instance.registerFactory<AddObjectViewModel>(() => AddObjectViewModel(instance())); 
  }
}

initEditObjectModule() {
  if (!GetIt.I.isRegistered<EditObjectUseCase>()) {
    instance.registerFactory<EditObjectUseCase>(() => EditObjectUseCase(instance()));
    instance.registerFactory<EditFormulaireViewModel>(() => EditFormulaireViewModel(instance())); 
  }
}



initDashModule() {
  if (!GetIt.I.isRegistered<DashUseCase>()) {
    instance.registerFactory<DashUseCase>(() => DashUseCase(instance()));
    instance.registerFactory<NotificationViewModel>(() => NotificationViewModel(instance())); 
  }
}



initObjectEditableDataModule() {
  if (!GetIt.I.isRegistered<ObjectEditableDataUseCase>() ) {
    instance.registerFactory<ObjectEditableDataUseCase>(() => ObjectEditableDataUseCase(instance()));
    instance.registerFactory<DeleteObjectUseCase>(() => DeleteObjectUseCase(instance()));
    instance.registerFactory<EditViewModel>(
        () => EditViewModel(instance(),instance()));
  }
}






initObjectDetailsModule() {
  if(!GetIt.I.isRegistered<ObjectDetailsUseCase>()){
    instance.registerFactory<ObjectDetailsUseCase>(
      () => ObjectDetailsUseCase(instance()));
    instance.registerFactory<ObjectDetailsViewModel>(
      () => ObjectDetailsViewModel(instance()));
  }
}





