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
      name: "무신사 스탠다드 슬랙스 랩 성수",
      latLng: LocationClass(latitude: 37.5258975, longitude: 126.9284261),
      type: "Cafe",
    ),
    Store(
      id: "2",
      name: "키뮤스튜디오",
      latLng: LocationClass(latitude: 37.5152131, longitude: 126.9408624),
      type: "Exhibition",
    ),
    Store(
      id: "3",
      name: "Stussy x Nike: the Collab",
      latLng: LocationClass(latitude: 37.5278165, longitude: 126.9291976),
      type: "Store",
    ),
    Store(
      id: "4",
      name: "Summer Bathcation",
      latLng: LocationClass(latitude: 37.5212731, longitude: 126.9323344),
      type: "Cafe",
    ),
    Store(
      id: "5",
      name: "RANG PA RANG PA",
      latLng: LocationClass(latitude: 37.5186349, longitude: 126.9266125),
      type: "Exhibition",
    ),
    Store(
      id: "6",
      name: "시몬스 그로서리 스토어 청담",
      latLng: LocationClass(latitude: 37.5254157, longitude: 126.9215157),
      type: "Store",
    ),
  ];
}