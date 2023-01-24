import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_map_custom_icon/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'class/map_related.dart' show House;

void main() => runApp(const GoogleMapCustomIcon());

class GoogleMapCustomIcon extends StatelessWidget {
  const GoogleMapCustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapProvider()..init(),
      child: MaterialApp(home: MapScreen()),
    );
  }
}

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
          children: <Widget>[
            Builder(
              builder: (BuildContext ctx) {
                final MapProvider _mapProvider = Provider.of(ctx);

                return GoogleMap(
                  initialCameraPosition: const CameraPosition(target: LatLng(37.5258975, 126.9284261), zoom: 14.0),
                  markers: _mapProvider.markers,
                  onMapCreated: (GoogleMapController ct) async {
                    this._mapController.complete(ct);
                    final GoogleMapController _ct = await this._mapController.future;
                    _ct.setMapStyle(
                        '['
                            '{"featureType": "poi","elementType": "labels", "stylers": [{"visibility": "off"}]},' //
                            '{"featureType": "poi.park","elementType": "geometry", "stylers": [{"visibility": "simplified"}]},'
                            '{"featureType": "road","elementType": "labels","stylers": [{"visibility": "off"}]},'
                            '{"featureType": "road.highway","elementType": "labels", "stylers": [{"visibility": "on"}]},'
                            '{"featureType": "road.arterial","elementType": "labels", "stylers": [{"visibility": "on"}]},'
                            '{"featureType": "road.local","elementType": "labels", "stylers": [{"visibility": "on"}]},'
                            '{"featureType": "road.highway.controlled_access","elementType": "labels", "stylers": [{"visibility": "on"}]},'
                            ']'
                    );
                  },
                );
              },
            ),
            Builder(
              builder: (BuildContext ctx) {
                final House? _selectedHouse = ctx.select<MapProvider, House?>((MapProvider p) => p.selectedHouse);
                if (_selectedHouse == null) return const SizedBox();
                return Positioned(
                  bottom: 50.0,
                  child: SizedBox(
                      width: _width,
                      height: _width * 0.4,
                      child: HouseInfo(house: _selectedHouse)
                  ),
                );
              },
            ),
          ],
        )
    );
  }
}

class HouseInfo extends StatelessWidget {
  const HouseInfo({Key? key, required this.house}) : super(key: key);
  final House house;

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;

    return Container(
      width: _width * 0.8,
      height: _width * 0.4,
      margin: EdgeInsets.only(left: _width * 0.02, right: _width * 0.03, ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(width: 1.5)
      ),
      child: Column(
        children: <Widget>[
          Text(house.shortDescription, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Text("whatever other details...."),
          )
        ],
      ),
    );
  }
}
