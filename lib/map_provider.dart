import 'package:flutter/foundation.dart';
import 'package:google_map_custom_icon/map_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'bubble_with_marker.dart';
import 'class/custom_marker.dart';
import 'class/map_related.dart';
import 'nine_patch.dart';

class MapProvider with ChangeNotifier {
  final MapService _mapService = MapService();
  final NinePatch _ninePatch = NinePatch();
  final BubbleWithMarker _bubbleWithMarker = BubbleWithMarker();

  MapProvider(){
    Future(() async {
      //await this.init();
      //await this.drawNine();
      await this.bubbleMarker();
    });
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
    this._markers.add(CustomStoresMarker(icon: _icon, stores: this.stores, onTapMarker: this.onTapMarker));
    this._unselectedMarker = _icon;
    this.notifyListeners();
  }

  Future<void> drawNine() async {
    await Future.forEach(this.stores, (Store store) async {
      // if (store.name.contains("RANG")) {
      //   final Uint8List _bytes = await this._ninePatch.ninePatchBubbleOriginal(storeName: store.name);
      //   final BitmapDescriptor _icon = BitmapDescriptor.fromBytes(_bytes);
      //   this._markers.add(CustomMarker(icon: _icon, store: store));
      //   return;
      // }
      final Uint8List _bytes = await this._ninePatch.marker(65.0);
      //final Uint8List _bytes = await this._ninePatch.ninePatchBubble360(storeName: store.name);
      final BitmapDescriptor _icon = BitmapDescriptor.fromBytes(_bytes);
      this._markers.add(CustomMarker(icon: _icon, store: store, hasBubble: true));
    });
    this.notifyListeners();
  }

  Future<void> bubbleMarker() async {
    await Future.forEach(this.stores, (Store store) async {
      final Uint8List _bytes = await this._bubbleWithMarker.bubble360WithMarker(storeName: store.name, circleWidth: 65.0);
      final BitmapDescriptor _icon = BitmapDescriptor.fromBytes(_bytes);
      this._markers.add(CustomMarker(icon: _icon, store: store, hasBubble: true));
    });
    this.notifyListeners();
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
      this._markers.add(CustomStoresMarker(stores: stores, icon: this._selectedMarker!, onTapMarker: this.onTapMarker));
    } else {
      this._markers.add(CustomStoresMarker(icon: this._unselectedMarker!, onTapMarker: this.onTapMarker, stores: stores));
    }
    this.notifyListeners();
  }
}