import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../resource/color.dart';

/// A custom widget class for customized [CachedNetworkImage]
class CustomCachedNetworkImage extends StatelessWidget {
  /// Creates an instance of [CustomCachedNetworkImage]
  const CustomCachedNetworkImage({
    super.key,
    required this.path,
    this.defaultIcon = const Icon(Icons.file_download_off, color: Colors.red),
    this.borderRadius,
  });

  /// This is the either a file path or url link of the media
  final String? path;

  /// This is the customized border radius of the image
  final BorderRadiusGeometry? borderRadius;

  /// This is the default icon
  final Icon defaultIcon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final white = mekongOrange(isLight);
    final surface = theme.colorScheme.surface;
    if (path == null || path?.isEmpty == true) {
      return _buildErrorIcon();
    }
    if (!Uri.parse(path!).isAbsolute && !File(path!).existsSync()) {
      return _buildErrorIcon();
    }
    if (Uri.parse(path!).isAbsolute) {
      return _buildCacheBody(surface, white);
    }
    return _buildImage(FileImage(File(path!)));
  }

  Widget _buildCacheBody(Color surface, Color white) {
    return CachedNetworkImage(
      imageUrl: path!,
      imageBuilder: (context, imageProvider) {
        return _buildImage(imageProvider);
      },
      progressIndicatorBuilder:
          (context, url, downloadProgress) =>
              _buildLoadingIndicator(downloadProgress, white),
      errorWidget: (context, url, error) => _buildErrorWidget(url, surface),
    );
  }

  Center _buildLoadingIndicator(
    DownloadProgress downloadProgress,
    Color white,
  ) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 1,
        value: downloadProgress.progress,
        color: white,
      ),
    );
  }

  Container _buildImage(ImageProvider<Object> imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image:
              !Uri.parse(path!).isAbsolute
                  ? FileImage(File(path!))
                  : imageProvider,
        ),
      ),
    );
  }

  StatelessWidget _buildErrorWidget(String url, Color surface) {
    if (!Uri.parse(url).isAbsolute) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(File(url)),
          ),
        ),
      );
    }
    return _buildErrorIcon();
  }

  Icon _buildErrorIcon() => defaultIcon;
}
