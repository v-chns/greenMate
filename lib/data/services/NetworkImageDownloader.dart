import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';

class NetworkImageDownloader{
  static Future<XFile?> downloadAndSaveImage(String imageUrl) async {
  try {
    // Create a Dio instance
    Dio dio = Dio();

    // Fetch the image bytes
    Response<List<int>> response = await dio.get<List<int>>(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    // Save the bytes to a file
    File file = File('${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(response.data!);

    // Convert the File to XFile
    XFile xFile = XFile(file.path);

    return xFile;
  } catch (e) {
    print('Error downloading and saving image: $e');
    return null;
  }
}

static Future<XFile> getImageXFileByUrl(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    XFile result = await XFile(file.path);
    return result;
  }

}