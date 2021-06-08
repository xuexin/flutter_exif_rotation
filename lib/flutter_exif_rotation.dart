import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class FlutterExifRotation {
  static const MethodChannel _channel =
      const MethodChannel('flutter_exif_rotation');

  /// Get the [path] of the image and fix the orientation.
  /// Return the [File] with the exif data fixed
  static Future<File> rotateImage({
    required String path,
    OutputFormat outputFormat = OutputFormat.JPG,
  }) async {
    String filePath = await (_channel.invokeMethod(
      'rotateImage',
      <String, dynamic>{
        'path': path,
        'save': false,
        'outputFormat': _getOutputFormatString(outputFormat)
      },
    ));
    return File(filePath);
  }

  static String _getOutputFormatString(OutputFormat outputFormat) {
    switch (outputFormat) {
      case OutputFormat.JPG:
        return 'jpg';
      case OutputFormat.PNG:
        return 'png';
      default:
        return 'jpg';
    }
  }
}

enum OutputFormat { JPG, PNG }
