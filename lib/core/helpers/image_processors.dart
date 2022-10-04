import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:informat/core/api_service/api_endpoints.dart';
import 'package:informat/core/constants/enum_constants.dart';

import 'package:http/http.dart' as client;

ImageProvider getImage(String path) {
  if (path.startsWith('http://') || path.startsWith('https://')) {
    // log('Coming with http: $path');
    return CachedNetworkImageProvider(path);
  } else if (path.contains('assets')) {
    // log('Coming without http: $path');
    return AssetImage(path);
  } else {
    // log('Coming without http: $path');
    return FileImage(File(path));
  }
}

String getImagePath(String path) {
  if (path.startsWith('http://') || path.startsWith('https://')) {
    return path;
  } else {
    return '$fileUrl$path';
  }
}

Future<String?> uploadImage(
  ImageSource source, {
  CropType? type,
}) async {
  final image = await ImagePicker().pickImage(source: source);

  if (image != null) {
    if (type != null) {
      return cropImage(image.path, type: type);
    } else {
      return image.path;
    }
  } else {
    return null;
  }
}

Future<String?> cropImage(String imagePath, {CropType? type}) async {
  // Proocess Aspect Ratio options
  CropAspectRatio fixRatio() {
    switch (type) {
      case CropType.Horiz:
        return const CropAspectRatio(ratioX: 4, ratioY: 3);
      case CropType.Vertz:
        return const CropAspectRatio(ratioX: 3, ratioY: 4);
      case CropType.Square:
        return const CropAspectRatio(ratioX: 1, ratioY: 1);
      default:
        return const CropAspectRatio(ratioX: 1, ratioY: 1);
    }
  }

  final image = await ImageCropper().cropImage(
    sourcePath: imagePath,
    aspectRatio: type != null ? fixRatio() : null,
  );

  if (image != null) {
    return image.path;
  } else {
    return null;
  }
}

//Encode Network Image to Base64String
Future<String> imageToString(String imageUrl) async {
  const String patchUrl = 'https://wowcatholic.s3.amazonaws.com/';

  client.Response response;

  if (imageUrl.startsWith('https://')) {
    response = await client.get(Uri.parse(imageUrl));
  } else {
    response = await client.get(Uri.parse(patchUrl + imageUrl));
  }
  final base64 = base64Encode(response.bodyBytes);

  return base64;
}

///Decodes Images file encoded to Base64String to Image
Uint8List imageFromString(String base64String) {
  return base64Decode(base64String);
}
