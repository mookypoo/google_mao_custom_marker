import 'dart:async' show FutureOr;


import 'package:flutter/animation.dart';
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

  // MapProvider(){
  //   print("map provider");
  //   Future(() async {
  //
  //     await this.init();
  //     //await this.drawNine();
  //     //await this.bubbleMarker();
  //   });
  // }

  final LatLng _latLng = const LatLng(37.5258975, 126.9284261);

  final List<House> houses = [...SampleData.houses];

  House? _selectedHouse;
  House? get selectedHouse => this._selectedHouse;
  set selectedHouse(House? h) => throw "error";

  List<Marker> _markers = [];
  Set<Marker> get markers => {...this._markers};
  set markers(Set<Marker> s) => throw "error";

  BitmapDescriptor? _unselectedMarker; /// has cluster number
  BitmapDescriptor? _selectedMarker; /// has store details

  bool isSelected = false;

  BitmapDescriptor? _unselectedIconMarker;
  BitmapDescriptor? _selectedIconMarker;

  Future<void> init() async {
    await this._setBitmapDescriptor();
    this._setIconMarkers();
  }

  Future<void> _setBitmapDescriptor() async {
    final Uint8List _unselected = await this._mapService.getBytesFromAsset(width: 100, path: "assets/marker_icon.png");
    this._unselectedIconMarker = BitmapDescriptor.fromBytes(_unselected);
    final Uint8List _selected = await this._mapService.getBytesFromAsset(width: 140, path: "assets/marker_icon.png");
    this._selectedIconMarker = BitmapDescriptor.fromBytes(_selected);
  }

   void _setIconMarkers() {
     if (this._unselectedIconMarker == null)return;
     this.houses.forEach((House house) => this._markers.add(CustomMarker(icon: this._unselectedIconMarker!, house: house, onTapHouse: this.onTapHouse)));
     this.notifyListeners();
  }

  // void _markerIconOnly() {
  //   await Future.forEach(this.houses, (House house) async {
  //     final Uint8List _bytes = await this._mapService.getBytesFromAsset(width: 100, path: "assets/marker_icon.png");
  //     final BitmapDescriptor _icon = BitmapDescriptor.fromBytes(_bytes);
  //     this._markers.add(CustomMarker(icon: _icon, house: house, onTapHouse: this.onTapHouse));
  //   });
  //   this.notifyListeners();
  // }

  void onTapHouse(House house) {
    this._selectedHouse = house;
    if (this._selectedIconMarker == null) return;
    this._markers.removeWhere((Marker marker) => marker.markerId.value == house.houseUid);
    this._markers.add(CustomMarker(icon: this._selectedIconMarker!, house: house, onTapHouse: this.onTapHouse));
    this.notifyListeners();
  }

  // Future<void> drawNine() async {
  //   await Future.forEach(this.houses, (House store) async {
  //     // if (store.name.contains("RANG")) {
  //     //   final Uint8List _bytes = await this._ninePatch.ninePatchBubbleOriginal(storeName: store.name);
  //     //   final BitmapDescriptor _icon = BitmapDescriptor.fromBytes(_bytes);
  //     //   this._markers.add(CustomMarker(icon: _icon, store: store));
  //     //   return;
  //     // }
  //     final Uint8List _bytes = await this._ninePatch.marker(65.0);
  //     //final Uint8List _bytes = await this._ninePatch.ninePatchBubble360(storeName: store.name);
  //     final BitmapDescriptor _icon = BitmapDescriptor.fromBytes(_bytes);
  //     this._markers.add(CustomMarker(icon: _icon, house: store, hasBubble: true));
  //   });
  //   this.notifyListeners();
  // }
  //
  // Future<void> bubbleMarker() async {
  //   await Future.forEach(this.houses, (House store) async {
  //     final Uint8List _bytes = await this._bubbleWithMarker.bubble360WithMarker(storeName: store.shortDescription, circleWidth: 65.0);
  //     final BitmapDescriptor _icon = BitmapDescriptor.fromBytes(_bytes);
  //     this._markers.add(CustomMarker(icon: _icon, house: store, hasBubble: true));
  //   });
  //   this.notifyListeners();
  // }

  // Future<void> onTapMarker(List<House> stores) async {
  //   this._markers.removeWhere((Marker m) => m.markerId.value == stores[0].houseUid);
  //   this.isSelected = !this.isSelected;
  //
  //   if (this.isSelected) {
  //     if (this._selectedMarker == null) {
  //       //final Uint8List _bytes = await this._mapService.getSelectedMarkerSimple(iconWidth: 130.0);
  //       final Uint8List _bytes = await this._mapService.getSelectedMarkerDetail(stores: stores, iconWidth: 130.0);
  //       this._selectedMarker = BitmapDescriptor.fromBytes(_bytes);
  //     }
  //     this._markers.add(CustomStoresMarker(stores: stores, icon: this._selectedMarker!, onTapMarker: this.onTapMarker));
  //   } else {
  //     this._markers.add(CustomStoresMarker(icon: this._unselectedMarker!, onTapMarker: this.onTapMarker, stores: stores));
  //   }
  //   this.notifyListeners();
  // }
}