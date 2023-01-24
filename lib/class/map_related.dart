import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class House {
  final String houseUid;
  final String shortDescription;
  final LocationClass latLng;

  const House({required this.houseUid, required this.shortDescription, required this.latLng});
}

class LocationClass extends LatLng {
  @override
  final double latitude;

  @override
  final double longitude;

  const LocationClass({required this.latitude, required this.longitude}) : super(latitude, longitude);

  factory LocationClass.fromJson({required double latitude, required double longitude}) =>
      LocationClass(longitude: longitude, latitude: latitude);

  factory LocationClass.fromLatLng(LatLng ln)=> LocationClass(
      latitude: ln.latitude,
      longitude: ln.longitude
  );
}

class SampleData {
  static const List<House> houses = [
    House(
      houseUid: "1",
      shortDescription: "2 bed, 1 bathroom",
      latLng: LocationClass(latitude: 37.5258975, longitude: 126.9284261),
    ),
    House(
      houseUid: "2",
      shortDescription: "cute patio on the rooftop ",
      latLng: LocationClass(latitude: 37.5152131, longitude: 126.9408624),
    ),
    House(
      houseUid: "3",
      shortDescription: "perfect for one person",
      latLng: LocationClass(latitude: 37.5278165, longitude: 126.9291976),
    ),
    House(
      houseUid: "4",
      shortDescription: "4 beds, 2 baths",
      latLng: LocationClass(latitude: 37.5212731, longitude: 126.9323344),
    ),
    House(
      houseUid: "5",
      shortDescription: "100 people favorited",
      latLng: LocationClass(latitude: 37.5186349, longitude: 126.9266125),
    ),
    House(
      houseUid: "6",
      shortDescription: "RENT DISCOUNT",
      latLng: LocationClass(latitude: 37.5254157, longitude: 126.9215157),
    ),
  ];
}