import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'class/map_related.dart';

class MapService {
  /// to use your images as markers
  Future<Uint8List> getBytesFromAsset({required String path, required int width}) async {
    final ByteData _data = await rootBundle.load(path);
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo _fi = await _codec.getNextFrame();
    final Uint8List _bytes = (await _fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
    return _bytes;
  }

  final Paint _paintInner =  Paint()..color = Colors.white;
  final Paint _paintBorder = Paint()..color = Colors.black..style = PaintingStyle.stroke..strokeWidth = 2.5;
  final Paint _innerShadowPaint = Paint()..color = Colors.black54..style..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);
  final Paint _outerShadowPaint = Paint()..color = Colors.black12..style..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);

  Future<ui.Image> clusterCircle({required int numOfStores, required double width}) async {
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final Canvas _canvas = Canvas(_pictureRecorder);
    final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr);
    final double _radius = width / 2;

    _canvas.drawCircle(Offset(_radius, _radius), _radius, this._paintInner);
    _canvas.drawCircle(Offset(_radius, _radius), _radius - 1.5, this._paintBorder);
    _textPainter.text = TextSpan(
      text: numOfStores.toString(),
      style: TextStyle(fontSize: _radius - 3, fontWeight: FontWeight.bold, color: Colors.black),
    );

    _textPainter.layout();
    _textPainter.paint(_canvas, Offset(_radius - _textPainter.width / 2, _radius - _textPainter.height / 2));

    final ui.Image _image = await _pictureRecorder.endRecording().toImage(_radius.toInt() * 2, _radius.toInt() * 2);
    return _image;
  }

  Future<Uint8List> getUnselectedMarker({required int numOfStores, required int iconWidth}) async {
    /// begin recording a canvas
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final ui.Canvas _canvas = ui.Canvas(_pictureRecorder);

    /// make asset image into ui.Image
    final ByteData _data = await rootBundle.load("assets/store_marker.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: iconWidth);
    final ui.Image _iconImage = (await _codec.getNextFrame()).image;

    /// marker includes icon + cluster image
    final double _clusterImageWidth = iconWidth - 10;
    final double _iconImageHeight = iconWidth * 1.24;
    final double _markerHeight = _iconImageHeight + (_clusterImageWidth/3) * 2; /// icon + 2/3 of cluster circle
    final double _markerWidth = iconWidth + (_clusterImageWidth/5)*2; /// icon + 2/5 of cluster circle

    final ui.Image _clusterImage = await clusterCircle(width: _clusterImageWidth, numOfStores: numOfStores);
    /// whatever is drawn last is at the top of the layer (just like a stack)
    /// top left corner of image will be drawn at the offset
    /// Offset.zero is top left corner
    _canvas.drawImage(_iconImage, Offset(0.0, _clusterImageWidth/3 * 2), Paint());
    _canvas.drawImage(_clusterImage, Offset(_markerWidth - _clusterImageWidth, 0.0), Paint());

    final ui.Image _image = await _pictureRecorder.endRecording().toImage(_markerWidth.toInt(), _markerHeight.toInt());
    final ByteData? _bytes = await _image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = await _bytes!.buffer.asUint8List();
    return _list;
  }

  Future<ui.Image> locationBubble({required String name, required double width, required double height, required bool isSimple, required List<Store> stores}) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas _canvas = Canvas(pictureRecorder);
    final TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr, maxLines: isSimple ? 1 : 1 + stores.length, ellipsis: "...");
    final Radius _radius = const Radius.circular(50.0);

    final ui.RRect _innerShadow = ui.RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(width/2, height/2 + 6.0), width: width-10.0, height: height), _radius,
    );
    final ui.RRect _outerShadow = ui.RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(width/2, height/2 + 12.0), width: width-10.0, height: height), _radius,
    );
    final ui.RRect _innerRect = ui.RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(width/2, height/2), width: width, height: height), _radius,
    );
    final ui.RRect _outerRect = ui.RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(width/2, height/2), width: width-1.5, height: height-1.5), _radius,
    );
    _canvas.drawRRect(_innerShadow, this._innerShadowPaint);
    _canvas.drawRRect(_outerShadow, this._outerShadowPaint);
    _canvas.drawRRect(_innerRect, this._paintInner);
    _canvas.drawRRect(_outerRect, this._paintBorder);

    String _subString(String s){
      if (s.length > 28.0) return s.substring(0, 28) + "...\n";
      return "$s\n";
    }

    TextSpan _text(Store store) => TextSpan(
      text: _subString("${store.type} - ${store.name}"),
      style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500, color: Colors.black, overflow: TextOverflow.ellipsis, height: 1.25,),
    );

    if (isSimple) {
      textPainter.text = TextSpan(
        text: "   $name : 6개",
        style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.black),
      );
    } else {
      textPainter.text = TextSpan(
        text: " $name : 6개\n",
        style: const TextStyle(fontSize: 43.0, fontWeight: FontWeight.bold, color: Colors.black, height: 1.9, overflow: TextOverflow.ellipsis),
        children: stores.map<TextSpan>(_text).toList()
      );
    }

    textPainter.layout();
    if (isSimple) textPainter.paint(_canvas, Offset(10.0, height/2 - 23.0));
    if (!isSimple) textPainter.paint(_canvas, const Offset(10.0, 30.0));

    final ui.Image _image = await pictureRecorder.endRecording().toImage(
        (width+10.0).toInt(), (height + 15).toInt()
    );
    return _image;
  }

  Future<Uint8List> getSelectedMarkerSimple({required double iconWidth, required List<Store> stores}) async {
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final ui.Canvas _canvas = ui.Canvas(_pictureRecorder);

    final ByteData _data = await rootBundle.load("assets/store_marker.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: iconWidth.toInt());
    final ui.FrameInfo _fi = await _codec.getNextFrame();

    final double _bubbleWidth = 350.0;
    final double _bubbleHeight = 100.0;
    final double _iconHeight = iconWidth * 1.24;
    final double _imageHeight = _bubbleHeight + _iconHeight + 20.0;
    final ui.Image _clusterImage = await locationBubble(name: "더현대서울", width: _bubbleWidth, height: _bubbleHeight, stores: stores, isSimple: true);

    _canvas.drawImage(_fi.image, Offset((_bubbleWidth/2) - iconWidth/2, _bubbleHeight + 20.0), Paint());
    _canvas.drawImage(_clusterImage, const Offset(5.0, 0.0), Paint());

    final ui.Image _image = await _pictureRecorder.endRecording().toImage((_bubbleWidth + 10.0).toInt(), _imageHeight.toInt());
    final ByteData? _bytes = await _image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = await _bytes!.buffer.asUint8List();
    return _list;
  }

  Future<Uint8List> getSelectedMarkerDetail({required List<Store> stores, required double iconWidth}) async {
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final ui.Canvas _canvas = ui.Canvas(_pictureRecorder);

    final ByteData _data = await rootBundle.load("assets/store_marker.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: iconWidth.toInt());
    final ui.FrameInfo _fi = await _codec.getNextFrame();

    final double _bubbleWidth = 600.0;
    final double _bubbleHeight = 100.0 + 60.0 * stores.length;
    final double _iconHeight = iconWidth * 1.24;
    final double _imageHeight = _bubbleHeight + _iconHeight + 20.0;
    final ui.Image _clusterImage = await locationBubble(name: "더현대서울", width: _bubbleWidth, height: _bubbleHeight, stores: stores, isSimple: false);

    _canvas.drawImage(_fi.image, Offset((_bubbleWidth/2) - iconWidth/2, _bubbleHeight + 20.0), Paint());
    _canvas.drawImage(_clusterImage, const Offset(5.0, 0.0), Paint());

    final ui.Image _image = await _pictureRecorder.endRecording().toImage((_bubbleWidth + 10.0).toInt(), _imageHeight.toInt());
    final ByteData? _bytes = await _image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = await _bytes!.buffer.asUint8List();
    return _list;
  }
}
