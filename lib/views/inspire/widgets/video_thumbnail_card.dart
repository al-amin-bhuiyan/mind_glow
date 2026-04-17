import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../controllers/inspire_controller/inspire_controller.dart';
import '../../../widgets/custom_assets.dart';

/// Video Thumbnail Card Widget
/// Displays video thumbnail with play button
class VideoThumbnailCard extends StatelessWidget {
  final VideoItem video;
  final VoidCallback onTap;

  const VideoThumbnailCard({
    Key? key,
    required this.video,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 168.w,
        height: 124.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x1A896D16),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 1,
            ),
            BoxShadow(
              color: const Color(0x0D896D16),
              blurRadius: 4,
              offset: const Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                video.thumbnailAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SvgPicture.asset(
                CustomAssets.video_icon_over_the_video_thumb,
                width: 33.w,
                height: 33.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}