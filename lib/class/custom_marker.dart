import 'dart:ui';

import 'package:google_map_custom_icon/class/map_related.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomStoresMarker extends Marker {
  final List<Store> stores;
  final Future<void> Function(List<Store>) onTapMarker;

  CustomStoresMarker({required this.stores, required super.icon, required this.onTapMarker})
    : super(
        markerId: MarkerId(stores[0].id),
        position: stores[0].latLng,
        consumeTapEvents: true,
        onTap: () async => await onTapMarker(stores),
      );
}

class CustomMarker extends Marker {
  final Store store;

  CustomMarker({required this.store, required super.icon, bool hasBubble = false,})
      : super(
    markerId: MarkerId(store.id),
    position: store.latLng,
    consumeTapEvents: true,
    anchor: !hasBubble ? Offset(0.5, 0.5) : Offset(0.1, 0.8)
    //onTap: () async => await onTapMarker(stores),
  );
  /// anchor Offset(0.5, 0.5) when just marker
}