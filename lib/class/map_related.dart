import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class Store {
  final String id;
  final String name;
  final String type;
  final LocationClass latLng;

  const Store({required this.id, required this.name, required this.type, required this.latLng});
}

class LocationClass extends LatLng {
  @override
  final double latitude;

  @override
  final double longitude;

  const LocationClass({required this.latitude, required this.longitude}) : super(latitude, longitude);

  factory LocationClass.fromJson({required double latitude, required double longitude}) =>
      LocationClass(longitude: longitude, latitude: latitude);

  //String get googleMapUrl => 'https://maps.googleapis.com/maps/api/staticmap?center=${this.latitude},${this.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C${this.latitude},${this.longitude}&key=$googleAPI';

  @override
  Object toJson() => super.toJson();

  factory LocationClass.fromLatLng(LatLng ln)=> LocationClass(
      latitude: ln.latitude,
      longitude: ln.longitude
  );
}

class SampleData {
  static const List<Store> stores = [
    Store(
      id: "1",
      name: "Best Coffee In The World",
      latLng: LocationClass(latitude: 37.5258975, longitude: 126.9284261),
      type: "Cafe",
    ),
    Store(
      id: "2",
      name: "Free Your Mind",
      latLng: LocationClass(latitude: 37.5258975, longitude: 126.9284261),
      type: "Exhibition",
    ),
    Store(
      id: "3",
      name: "Stussy x Nike: the Collab",
      latLng: LocationClass(latitude: 37.5258975, longitude: 126.9284261),
      type: "Store",
    ),
    Store(
      id: "4",
      name: "Coffee is On Me!",
      latLng: LocationClass(latitude: 37.5258975, longitude: 126.9284261),
      type: "Cafe",
    ),
    Store(
      id: "5",
      name: "Your Local Artists",
      latLng: LocationClass(latitude: 37.5258975, longitude: 126.9284261),
      type: "Exhibition",
    ),
    Store(
      id: "6",
      name: "Anime Shop",
      latLng: LocationClass(latitude: 37.5258975, longitude: 126.9284261),
      type: "Store",
    ),
  ];
}