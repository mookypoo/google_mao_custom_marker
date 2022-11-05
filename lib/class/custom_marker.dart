import 'package:google_map_custom_icon/class/map_related.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends Marker {
  final List<Store> stores;
  final Future<void> Function(List<Store>) onTapMarker;

  CustomMarker({required this.stores, required super.icon, required this.onTapMarker})
    : super(
        markerId: MarkerId(stores[0].id),
        position: stores[0].latLng,
        consumeTapEvents: true,
        onTap: () async => await onTapMarker(stores),
      );
}