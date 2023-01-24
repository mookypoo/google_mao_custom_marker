import 'dart:async' show FutureOr;
import 'dart:ui';

import 'package:google_map_custom_icon/class/map_related.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends Marker {
  final House house;
  final FutureOr<void> Function(House house) onTapHouse;

  CustomMarker({required this.house, required super.icon, bool hasBubble = false, required this.onTapHouse})
    : super(
        markerId: MarkerId(house.houseUid),
        position: house.latLng,
        consumeTapEvents: true,
        anchor: !hasBubble ? const Offset(0.5, 0.5) : const Offset(0.1, 0.8),
        onTap: () async => await onTapHouse(house),
    // ) async => await
      );
}

