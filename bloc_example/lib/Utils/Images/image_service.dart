import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageServiceUtil {
  ImageServiceUtil._privateConstructor();
  static final ImageServiceUtil _instance = ImageServiceUtil._privateConstructor();
  factory ImageServiceUtil() {
    return _instance;
  }
  Widget getImage(String imageUrl) {
    CachedNetworkImage cachedNetworkImage = CachedNetworkImage(
       imageUrl: imageUrl,
       progressIndicatorBuilder: (context, url, downloadProgress) => 
               CircularProgressIndicator(value: downloadProgress.progress),
       errorWidget: (context, url, error) => const Icon(Icons.error),
    );
    return cachedNetworkImage;
  }
}
