import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageUrlCache {
  static final ImageUrlCache _instance = ImageUrlCache._internal();

  final Map<String, CachedSignedUrl> _cache = {};

  final int validDurationSeconds;

  ImageUrlCache._internal({this.validDurationSeconds = 3600});

  factory ImageUrlCache({int validDurationSeconds = 3600}) {
    return _instance;
  }

  Future<String> getSignedUrl(String bucket, String path) async {
    final now = DateTime.now();
    final cached = _cache[path];

    if (cached != null && cached.expiration.isAfter(now)) {
      return cached.url;
    }

    final signedUrl = await Supabase.instance.client.storage
        .from(bucket)
        .createSignedUrl(path, validDurationSeconds);

    final expiration = now.add(Duration(seconds: validDurationSeconds));

    _cache[path] = CachedSignedUrl(url: signedUrl, expiration: expiration);

    return signedUrl;
  }
}

class CachedSignedUrl {
  final String url;
  final DateTime expiration;

  CachedSignedUrl({required this.url, required this.expiration});
}
