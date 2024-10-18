import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileConverterService{
  static Future<XFile> assetToXFile(String assetPath) async {
    // Load the asset as bytes
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List();

    // Get the temporary directory path
    String tempDirPath = (await getTemporaryDirectory()).path;

    // Write the bytes to a file in the temporary directory
    String filePath =
        '$tempDirPath/${DateTime.now().millisecondsSinceEpoch}.png';
    await File(filePath).writeAsBytes(bytes);

    // Return the XFile
    return XFile(filePath);
  }
}