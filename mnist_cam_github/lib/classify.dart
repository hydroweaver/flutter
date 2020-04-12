import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io' as io;

import 'package:flutter/services.dart';

import 'package:image/image.dart';
import 'package:tflite/tflite.dart';


Future classifyImage(String imgFile) async {

  await Tflite.loadModel(model: 'assets/model/mnist.tflite', labels: 'assets/model/labels.txt');

  var imageBytes = io.File(imgFile).readAsBytesSync().buffer;

  Image oriImage = decodeJpg(imageBytes.asUint8List());
  Image resizedImage = copyResize(oriImage, height: 28, width: 28);

  var convertedBytes = Float32List(28 * 28);
  var buffer = Float32List.view(convertedBytes.buffer);
  int pixelIndex = 0;
  for (var i = 0; i < 28; i++) {
    for (var j = 0; j < 28; j++) {
      var pixel = resizedImage.getPixel(i, j);
      buffer[pixelIndex++] =
          (getRed(pixel) + getGreen(pixel) + getBlue(pixel)) / 3 / 255.0;
    }
  }

  var x = convertedBytes.buffer.asUint8List();

  List recognitions = await Tflite.runModelOnBinary(binary: x);

  print(recognitions);

  Tflite.close(); 
}
