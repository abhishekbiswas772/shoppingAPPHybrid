import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class ImageServiceUtil {
  static Widget getImage(String imageUrl) {
    CachedNetworkImage cachedNetworkImage = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
    return cachedNetworkImage;
  }

  static Widget getProfileImageWidgetFromName(String name, int? fontSize) {
    return ProfilePicture(
      name: name,
      radius: 40,
      fontsize: fontSize?.toDouble() ?? 15,
    );
  }
}
