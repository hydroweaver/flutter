import 'dart:typed_data' show Float32List, Uint8List;
import 'dart:ui' show Picture, PictureRecorder;

import 'package:flttf/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';
import 'dart:io' as io;
import 'package:image/image.dart' as Imageprocess;

class Recognizer {
  Future loadModel() => Tflite.loadModel(
    model: "models/mnist/karan_mnist.tflite",
    labels: "models/mnist/labels.txt",
  ).catchError((e, s) => debugPrint("loading model failure: $e $s"));

  Future recognize(List<Offset> points) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder, _canvasCullRect)..scale(canvasScale);

    // background of the image
    canvas.drawRect(Rect.fromLTWH(0, 0, _imageSize, _imageSize), _bgPaint);

    // draw lines connecting the points
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i] + _canvasOffset, points[i + 1] + _canvasOffset, _fgPaint);
      }
    }

    // create image from the canvas
    final picture = recorder.endRecording();
    Uint8List bytes = await _toGreyScaleBytes(picture, modelInputSize);
    //3136 length and bytes size
    return _predict(bytes);
  }

  Future<Uint8List> _toGreyScaleBytes(Picture pic, int size) async {
    final img = await pic.toImage(size, size);
    
    final imgBytes = await img.toByteData(); //3136 bytes size

    await io.File('/storage/emulated/0/Download/x.png').writeAsBytes(imgBytes.buffer.asUint8List().toList()).then((onValue)async{
      print(await onValue.exists());
    });
    
    final resultBytes = Float32List(size * size);
    final buffer = Float32List.view(resultBytes.buffer);
    int index = 0;
    for (int i = 0; i < imgBytes.lengthInBytes; i += 4) {
      final r = imgBytes.getUint8(i);
      final g = imgBytes.getUint8(i + 1);
      final b = imgBytes.getUint8(i + 2);
      buffer[index++] = (r + g + b) / 3.0 / 255.0;
    }
    await _loadAssetImage();
    return resultBytes.buffer.asUint8List();
  }

  Future _loadAssetImage() async{
    final asset_image = await rootBundle.load('images/predict1.jpg');
    final im2 = await Imageprocess.decodeImage(asset_image.buffer.asUint8List());
    final im3 = await Imageprocess.copyResize(im2, height: 28, width: 28);

    var x = await io.File('/storage/emulated/0/Download/x.png').readAsBytes();

    final resultBytes1 = Float32List(28 * 28);
    final buffer = Float32List.view(resultBytes1.buffer);
    int index = 0;
    for (int i = 0; i < x.lengthInBytes; i += 4) {
      final r = x.buffer.asUint8List()[i];
      final g = x.buffer.asUint8List()[i + 1];
      final b = x.buffer.asUint8List()[i + 2];
      buffer[index++] = (r + g + b) / 3.0 / 255.0;
    }
    
    var x1 = await _predict(resultBytes1.buffer.asUint8List());
  print("Confidence of retrieved image is : $x1");
    

  }

  Future _predict(Uint8List bytes) => Tflite.runModelOnBinary(
    binary: bytes,
  ).catchError((e, s) => debugPrint("prediction failure: $e $s"));
}

const _imageSize = canvasSize + 2 * canvasPadding;
const _canvasOffset = Offset(canvasPadding, canvasPadding);
final _canvasCullRect = Rect.fromPoints(Offset(0.0, 0.0), Offset(_imageSize, _imageSize));

final Paint _whitePaint = Paint()
  ..strokeCap = StrokeCap.square
  ..isAntiAlias = isAntiAlias
  ..color = Colors.white
  ..strokeWidth = strokeWidth;

final _bgPaint = Paint()..color = Colors.black;
final _fgPaint = _whitePaint;
