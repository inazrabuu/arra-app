import 'package:arrajewelry/data/image_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCloud extends StatelessWidget {
  final String path;
  final String bucket;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const ImageCloud({
    super.key,
    required this.path,
    required this.bucket,
    this.width = 200,
    this.height = 200,
    this.fit = BoxFit.cover,
    this.loadingWidget,
    this.errorWidget,
  });

  Future<String> _getImageUrl() async {
    return await ImageUrlCache().getSignedUrl(bucket, path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getImageUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return errorWidget ??
              Icon(Icons.broken_image_rounded, color: Colors.grey);
        } else {
          return CachedNetworkImage(
            imageUrl: snapshot.data!,
            width: width,
            height: height,
            fit: fit,
          );
        }
      },
    );
  }
}
