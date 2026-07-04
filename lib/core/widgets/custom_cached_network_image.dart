import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, this.height, this.width , required this.imagePath});
  final double? height;
  final double? width;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? 80,
      width: width ?? 180,
      fit: BoxFit.cover,
      imageUrl: imagePath,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
