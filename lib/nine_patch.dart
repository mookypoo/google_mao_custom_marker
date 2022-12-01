import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NinePatch {

  Future<Uint8List> ninePatchBubble340({required String storeName}) async {
    /// w340 = height 145, width = 385
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final ui.Canvas _canvas = ui.Canvas(_pictureRecorder);
    final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr, ellipsis: "...",);
    _textPainter.text = TextSpan(text: storeName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 38.0, overflow: TextOverflow.ellipsis));
    _textPainter.layout(maxWidth: 360.0);

    final ByteData _data = await rootBundle.load("assets/store_340.9.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List());
    final ui.FrameInfo _fi = await _codec.getNextFrame();

    const double _leftMargin = 110.0;
    const double _rightMargin = 50.0;
    final double _imageWidth = _textPainter.width + _leftMargin + _rightMargin;
    const double _imageHeight = 145.0;

    const Rect _center = Rect.fromLTRB(_leftMargin, 20.0, 170.0, 70.0);
    final Rect _dst = Rect.fromLTWH(0.0, 0.0, _imageWidth, _imageHeight);

    _canvas.drawImageNine(_fi.image, _center, _dst, Paint());
    _textPainter.paint(_canvas, const Offset(_leftMargin, 44.0));
    final ui.Image _iamge = await _pictureRecorder.endRecording().toImage(_imageWidth.toInt(), _imageHeight.toInt());
    final ByteData? _bytes = await _iamge.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = _bytes!.buffer.asUint8List();
    return _list;
  }

  Future<Uint8List> ninePatchBubble360({required String storeName}) async {
    /// w340 = height 155, width = 409
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final ui.Canvas _canvas = ui.Canvas(_pictureRecorder);
    final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr, ellipsis: "...",);
    _textPainter.text = TextSpan(text: storeName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 38.8, overflow: TextOverflow.ellipsis));
    _textPainter.layout(maxWidth: 360.0);

    final ByteData _data = await rootBundle.load("assets/store_360.9.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List());
    final ui.FrameInfo _fi = await _codec.getNextFrame();

    const double _leftMargin = 116.0;
    const double _rightMargin = 56.0;
    final double _imageWidth = _textPainter.width + _leftMargin + _rightMargin;
    const double _imageHeight = 155.0;

    const Rect _center = Rect.fromLTRB(_leftMargin, 20.0, 170.0, 70.0);
    final Rect _dst = Rect.fromLTWH(0.0, 0.0, _imageWidth, _imageHeight);

    _canvas.drawImageNine(_fi.image, _center, _dst, Paint());
    _textPainter.paint(_canvas, const Offset(_leftMargin, 49.0));
    final ui.Image _iamge = await _pictureRecorder.endRecording().toImage(_imageWidth.toInt(), _imageHeight.toInt());
    final ByteData? _bytes = await _iamge.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = _bytes!.buffer.asUint8List();
    return _list;
  }

  Future<Uint8List> ninePatchBubble380({required String storeName}) async {
    /// height 157, width = 418
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final ui.Canvas _canvas = ui.Canvas(_pictureRecorder);
    final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr, ellipsis: "...",);
    _textPainter.text = TextSpan(text: storeName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 39.5, overflow: TextOverflow.ellipsis));
    _textPainter.layout(maxWidth: 360.0);

    final ByteData _data = await rootBundle.load("assets/store_380.9.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List());
    final ui.FrameInfo _fi = await _codec.getNextFrame();

    const double _leftMargin = 122.5;
    const double _rightMargin = 55.0;
    final double _imageWidth = _textPainter.width + _leftMargin + _rightMargin;
    const double _imageHeight = 157.0;

    //const Rect _center = Rect.fromLTRB(_leftMargin, 20.0, 170.0, 70.0);
    const Rect _center = Rect.fromLTRB(_leftMargin, 0.0, 170.0, 100.0);
    final Rect _dst = Rect.fromLTWH(0.0, 0.0, _imageWidth, _imageHeight);

    _canvas.drawImageNine(_fi.image, _center, _dst, Paint());
    _textPainter.paint(_canvas, const Offset(_leftMargin, 46.7));
    final ui.Image _iamge = await _pictureRecorder.endRecording().toImage(_imageWidth.toInt(), _imageHeight.toInt());
    final ByteData? _bytes = await _iamge.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = _bytes!.buffer.asUint8List();
    return _list;
  }

  Future<Uint8List> ninePatchBubbleOriginal({required String storeName}) async {
    final ByteData _data = await rootBundle.load("assets/store_360.9.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List());
    final ui.FrameInfo _fi = await _codec.getNextFrame();
    print("height: ${_fi.image.height}, width: ${_fi.image.width}");
    final ByteData? _bytes = await _fi.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = await _bytes!.buffer.asUint8List();
    return _list;
  }

  Future<Uint8List> marker(double width) async {
    final ByteData _data = await rootBundle.load("assets/marker_65.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: width.toInt());
    final ui.FrameInfo _fi = await _codec.getNextFrame();

    final ByteData? _bytes = await _fi.image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = await _bytes!.buffer.asUint8List();
    return _list;
  }

}