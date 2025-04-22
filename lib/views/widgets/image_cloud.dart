import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final client = Supabase.instance.client;

    final response = await client.storage
        .from(bucket)
        .createSignedUrl(path, 60);

    return response;
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
          return Image.network(
            snapshot.data!,
            width: width,
            height: height,
            fit: fit,
          );
        }
      },
    );
  }
}
