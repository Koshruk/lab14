import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


class NativeCodeService {
  static const MethodChannel _channel = MethodChannel('com.lntu/native_code');

  static Future<String?> getNativeData() async{
    final String? nativeData = await _channel.invokeMethod('getNativeData');
    return nativeData;
  }
}

Future<String> fetchData() async{
  try {
    String? dataFromNative = await NativeCodeService.getNativeData();
    print('Data from native: $dataFromNative');
    if (dataFromNative == null || dataFromNative.isEmpty) {
      return 'Data was not found';
    }
    return dataFromNative;
  } catch (e) {
    print('Error: $e');
    return 'Failed to fetch data';
  }
}



