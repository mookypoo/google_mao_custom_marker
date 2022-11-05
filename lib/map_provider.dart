import 'package:flutter/foundation.dart';
import 'package:google_map_custom_icon/map_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'class/custom_marker.dart';
import 'class/map_related.dart';

class MapProvider with ChangeNotifier {
  final MapService _mapService = MapService();

  MapProvider(){
    Future(this.init);
  }

  final LatLng _latLng = const LatLng(37.5258975, 126.9284261);

  final List<Store> stores = [...SampleData.stores];

  Set<Marker> _markers = {};
  Set<Marker> get markers => {...this._markers};
  set markers(Set<Marker> s) => throw "error";

  BitmapDescriptor? _unselectedMarker; /// has cluster number
  BitmapDescriptor? _selectedMarker; /// has store details

  bool isSelected = false;

  Future<void> init() async {
    final Uint8List _bytes = await this._mapService.getUnselectedMarker(numOfStores: this.stores.length, iconWidth: 85);
    final BitmapDescriptor _icon = BitmapDescriptor.fromBytes(_bytes);
    this._markers.add(CustomMarker(icon: _icon, stores: this.stores, onTapMarker: this.onTapMarker));
    this.notifyListeners();
    this._unselectedMarker = _icon;
  }

  Future<void> onTapMarker(List<Store> stores) async {
    this._markers.removeWhere((Marker m) => m.markerId.value == stores[0].id);
    this.isSelected = !this.isSelected;

    if (this.isSelected) {
      if (this._selectedMarker == null) {
        //final Uint8List _bytes = await this._mapService.getSelectedMarkerSimple(iconWidth: 130.0);
        final Uint8List _bytes = await this._mapService.getSelectedMarkerDetail(stores: stores, iconWidth: 130.0);
        this._selectedMarker = BitmapDescriptor.fromBytes(_bytes);
      }
      this._markers.add(CustomMarker(stores: stores, icon: this._selectedMarker!, onTapMarker: this.onTapMarker));
    } else {
      this._markers.add(CustomMarker(icon: this._unselectedMarker!, onTapMarker: this.onTapMarker, stores: stores));
    }
    this.notifyListeners();
  }
}