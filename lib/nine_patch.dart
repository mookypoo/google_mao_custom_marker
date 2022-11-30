import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NinePatch {
  // Future<Uint8List> ninePatchBubble({required String storeName}) async {
  //   // //storeName = "헬로키티 문방구";
  //   // storeName = "Dior 성수";
  //   // //storeName = "무신사 x Adidas: the collab";
  //   final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
  //   final ui.Canvas _canvas = ui.Canvas(_pictureRecorder);
  //   final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr, maxLines: 1)..ellipsis = "...";
  //   _textPainter.text = TextSpan(text: storeName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 42.0, overflow: TextOverflow.ellipsis));
  //   _textPainter.layout(maxWidth: 360.0);
  //
  //   //final ByteData _data = await rootBundle.load("assets/bubble_resize.9.png");
  //   //final ByteData _data = await rootBundle.load("assets/bubble_resize_longer.9.png");
  //   final ByteData _data = await rootBundle.load("assets/bubble.9.png");
  //   final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List());
  //   final ui.FrameInfo _fi = await _codec.getNextFrame();
  //
  //   // min 250
  //   final double _textWidth = _textPainter.width < 250 ? 250.0 : _textPainter.width;
  //
  //   final double _imageWidth = _textWidth + 100.0;
  //   final double _imageHeight = 140.0;
  //
  //   final Rect _center = Rect.fromCenter(center: Offset(_textWidth/2, _textPainter.height/2), width: _textWidth + 70.0, height: _textPainter.height);
  //   //final Rect _center = Rect.f
  //   final Rect _dst = ui.Rect.fromLTWH(0.0, 0.0, _imageWidth, _imageHeight);
  //
  //   _canvas.drawImageNine(_fi.image, _dst, _dst, Paint());
  //   _textPainter.paint(_canvas, Offset((_imageWidth - _textPainter.width) / 2, 40.0));
  //   final ui.Image _iamge = await _pictureRecorder.endRecording().toImage(_imageWidth.toInt(), _imageHeight.toInt());
  //   final ByteData? _bytes = await _iamge.toByteData(format: ui.ImageByteFormat.png);
  //   final Uint8List _list = await _bytes!.buffer.asUint8List();
  //   return _list;
  // }

  Future<Uint8List> ninePatchBubble({required String storeName}) async {
    /// image size: 235 (x) 102 (y)
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final ui.Canvas _canvas = ui.Canvas(_pictureRecorder);
    final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr, maxLines: 1)..ellipsis = "...";
    _textPainter.text = TextSpan(text: storeName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 42.0, overflow: TextOverflow.ellipsis));
    _textPainter.layout(maxWidth: 360.0);

    final ByteData _data = await rootBundle.load("assets/bubble.9.png");
    final ui.Codec _codec = await ui.instantiateImageCodec(_data.buffer.asUint8List());
    final ui.FrameInfo _fi = await _codec.getNextFrame();

    final double _textWidth = _textPainter.width < 235 ? 235.0 : _textPainter.width;

    final double _imageWidth = _textWidth + 100.0;
    final double _imageHeight = 140.0;

    //final Rect _center = Rect.fromCenter(center: Offset(_textWidth/2, 40.0), width: _textWidth + 70.0, height: _textPainter.height);
    //final Rect _center = Rect.fromLTWH(57.0, 20.0, _textWidth, _textPainter.height);
    //final Rect _center = Rect.fromLTRB(57.0, 20.0, 170.0, 70.0);
    final Rect _center = Rect.fromLTRB(57.0, 20.0, 170.0, 70.0);
    final Rect _dst = Rect.fromLTWH(0.0, 0.0, _imageWidth, _imageHeight);

    _canvas.drawImageNine(_fi.image, _center, _dst, Paint());
    _textPainter.paint(_canvas, Offset((_imageWidth - _textPainter.width) / 2, 20.0));
    final ui.Image _iamge = await _pictureRecorder.endRecording().toImage(_imageWidth.toInt(), _imageHeight.toInt());
    final ByteData? _bytes = await _iamge.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List _list = await _bytes!.buffer.asUint8List();
    return _list;
  }
}