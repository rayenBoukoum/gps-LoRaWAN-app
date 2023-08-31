import 'package:charts_flutter/flutter.dart' as charts;

// onBoarding models
class SliderObject {

  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);

}

class SliderViewObject {

  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);

}

// login models

class Customer {

  String id;
  String name;
  int numberOfNotification;

  Customer(this.id, this.name, this.numberOfNotification);

}

class Contacts {

  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {

  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}


class Position {

  double long;
  double lat;

  Position(this.long, this.lat);

}

class OneObject {

  String id;
  double batteryLevel;
  String type;
  String name;
  Position? position;

  OneObject(this.id,this.batteryLevel, this.type, this.name, this.position);

}

class MapObjects {

  List<OneObject> objects;

  MapObjects(this.objects);

}

class ObjectDetails {

  String id;
  double batteryLevel;
  String type;
  String createdAt;
  String name;
  double farFromYou;
  Position? position;
  ObjectDetails(this.id,this.batteryLevel, this.type, this.createdAt, this.name, this.farFromYou, this.position);
}


class BarChartModel {
  String type;
  int nember;
  final charts.Color color;

  BarChartModel({required this.type, required this.nember, required this.color});
}