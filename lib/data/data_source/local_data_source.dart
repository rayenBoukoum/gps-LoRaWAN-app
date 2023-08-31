import 'package:http_course/data/network/error_handler.dart';
import 'package:http_course/data/responses/responses.dart';



const CACHE_MAP_OBJECT_KEY = "CACHE_MAP_OBJECT_KEY";
const CACHE_MAP_OBJECT_INTERVAL = 30*1000; // 1 minute cache in millis

const CACHE_MAP_OBJECT_KEY_2 = "CACHE_MAP_OBJECT_KEY_2";
const CACHE_MAP_OBJECT_INTERVAL_2 = 30*1000; // 1

const CACHE_OBJECT_EDITABLE_DATA_KEY = "CACHE_OBJECT_EDITABLE_DATA_KEY";
const CACHE_OBJECT_EDITABLE_DATA_INTERVAL = 30*1000; // 1



const CACHE_DASH_KEY = "CACHE_DASH_KEY";
const CACHE_DASH_KEY_INTERVAL = 30*1000; // 1





const CACHE_OBJECT_DETAILS_KEY = "CACHE_OBJECT_DETAILS_KEY";
const CACHE_OBJECT_DETAILS_INTERVAL = 3;//0 * 1000; // 30s in millis



abstract class LocalDataSource {


  Future<MapObjectsResponse> getMapObjectData();
  Future<void> saveMapObjectDataToCache(MapObjectsResponse mapObjectsResponse);

  Future<MapObjectsResponse> getObjectEditableData();
  Future<void> saveObjectEditableDataToCache(MapObjectsResponse mapObjectsResponse);


  Future<MapObjectsResponse> getDashData();
  Future<void> saveDashDataToCache(MapObjectsResponse mapObjectsResponse);


  Future<MapObjectsResponse> getMapObjectData2();
  Future<void> saveMapObjectDataToCache2(MapObjectsResponse mapObjectsResponse);




  Future<ObjectDetailsResponse> getObjectDetails();
  Future<void> saveObjectDetailsToCache(ObjectDetailsResponse response);

  // Cache methodes
  void clearCache();
  void removeFromCache(String key);

}

class LocalDataSourceImpl implements LocalDataSource {

  // run time cache
  Map<String, CachedItem> cachedMap = Map();





  // detail of one object
  @override
  Future<ObjectDetailsResponse> getObjectDetails() async{
    CachedItem? cachedItem = cachedMap[CACHE_OBJECT_DETAILS_KEY];

    if (cachedItem != null &&
        cachedItem.isValid(CACHE_OBJECT_DETAILS_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handel(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveObjectDetailsToCache(ObjectDetailsResponse response) async {
    cachedMap[CACHE_OBJECT_DETAILS_KEY] = CachedItem(response);
  }
  

  // search Page list of object
  @override
  Future<MapObjectsResponse> getMapObjectData() async{
    CachedItem? cachedItem = cachedMap[CACHE_MAP_OBJECT_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_MAP_OBJECT_INTERVAL)) {
      // return the response from the cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handel(DataSource.CACHE_ERROR);
    }
  }
  
  @override
  Future<void> saveMapObjectDataToCache(MapObjectsResponse mapObjectsResponse) async{
    cachedMap[CACHE_MAP_OBJECT_KEY] = CachedItem(mapObjectsResponse);
  }

  
  // cache methodes 
    
  @override
  void clearCache() {
    cachedMap.clear();
  }
  
  @override
  void removeFromCache(String key) {
    cachedMap.remove(key);
  }
  
  @override
  Future<MapObjectsResponse> getMapObjectData2() async{
    CachedItem? cachedItem = cachedMap[CACHE_MAP_OBJECT_KEY_2];
    if(cachedItem != null && cachedItem.isValid(CACHE_MAP_OBJECT_INTERVAL_2)) {
      // return the response from the cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handel(DataSource.CACHE_ERROR);
    }
  }
  
  @override
  Future<void> saveMapObjectDataToCache2(MapObjectsResponse mapObjectsResponse) async{
    cachedMap[CACHE_MAP_OBJECT_KEY_2] = CachedItem(mapObjectsResponse);
  }



  

  
  @override
  Future<MapObjectsResponse> getDashData() async{
    CachedItem? cachedItem = cachedMap[CACHE_DASH_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_DASH_KEY_INTERVAL)) {
      // return the response from the cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handel(DataSource.CACHE_ERROR);
    }
  }
  
  @override
  Future<void> saveDashDataToCache(MapObjectsResponse mapObjectsResponse) async{
    cachedMap[CACHE_DASH_KEY] = CachedItem(mapObjectsResponse);
  }
  
  @override
  Future<MapObjectsResponse> getObjectEditableData() async{
    CachedItem? cachedItem = cachedMap[CACHE_OBJECT_EDITABLE_DATA_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_OBJECT_EDITABLE_DATA_INTERVAL)) {
      // return the response from the cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handel(DataSource.CACHE_ERROR);
    }
  }
  
  @override
  Future<void> saveObjectEditableDataToCache(MapObjectsResponse mapObjectsResponse) async{
    cachedMap[CACHE_OBJECT_EDITABLE_DATA_KEY] = CachedItem(mapObjectsResponse);
  }
  



}

class CachedItem {

  dynamic data;
  
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);


}


extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeMillis - cacheTime <= expirationTimeInMillis;
    // exemple
    // expirationTimeInMillis -> 60 sec
    // currentTimeMillis -> 1:00:00
    // cacheTime -> 12:59:30
    // valid -> until 1:00:30
    return isValid;
  }
}