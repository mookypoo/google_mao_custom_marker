import 'package:flutter/material.dart';
import 'package:google_map_custom_icon/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'class/map_related.dart' show Store;

void main(){
  runApp(const GoogleMapCustomIcon());
}

class GoogleMapCustomIcon extends StatelessWidget {
  const GoogleMapCustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapProvider(),
      child: const MaterialApp(home: MapScreen()),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    final MapProvider _mapProvider = Provider.of(context);
    final double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: const CameraPosition(target: LatLng(37.5258975, 126.9284261), zoom: 14.0),
            markers: _mapProvider.markers,
          ),
          _mapProvider.isSelected
            ? Positioned(
                bottom: 50.0,
                child: SizedBox(
                  width: _width,
                  height: _width * 0.4,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _mapProvider.stores.length,
                    itemBuilder: (_, int i) => StoreInfo(store: _mapProvider.stores[i]),
                  ),
                ),
              )
            : const SizedBox()
        ],
      )
    );
  }
}

class StoreInfo extends StatelessWidget {
  const StoreInfo({Key? key, required this.store}) : super(key: key);
  final Store store;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(store.name, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
              Text(store.type, style: const TextStyle(fontSize: 14.0),)
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0),
            child: Text("whatever other details...."),
          )
        ],
      ),
    );
  }
}
