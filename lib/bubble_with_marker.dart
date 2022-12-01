import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BubbleWithMarker {
  Future<Uint8List> bubble360WithMarker({required String storeName, required double circleWidth}) async {
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
    const double _bubbleHeight = 155.0;

    const Rect _center = Rect.fromLTRB(_leftMargin, 20.0, 170.0, 70.0);
    final Rect _dst = Rect.fromLTWH(0.0, 0.0, _imageWidth, _bubbleHeight);

    _canvas.drawImageNine(_fi.image, _center, _dst, Paint());
    _textPainter.paint(_canvas, const Offset(_leftMargin, 49.0));

    final ui.Image _circle = await this._circle(65.0);
    print("marker height ${_circle.height}");
    _canvas.drawImage(_circle, Offset(40.0, _bubbleHeight - 18.0), Paint());

    final ui.Image _iamge = await _pictureRecorder.endRecording().toImage(_imageWidth.toInt(),( _bubbleHeight + circleWidth).toInt());
    final ByteData? _bytes = await _iamge.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = _bytes!.buffer.asUint8List();
    return _list;
  }

  Future<ui.Image> _circle(double width) async {
    final ByteData _data = await rootBundle.load("assets/marker_65.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List(), targetWidth: width.toInt());
    final ui.FrameInfo _fi = await _codec.getNextFrame();
    return _fi.image;
  }
}