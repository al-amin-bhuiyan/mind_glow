import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import 'package:mind_glow/utils/app_colors.dart';
import '../../../controllers/inspire_controller/inspire_controller.dart';
import '../../../utils/app_fonts.dart';

/// Featured Quote Card Widget
/// Displays the main featured quote at the top of inspire screen
class FeaturedQuoteCard extends StatelessWidget {
  final FeaturedQuote quote;

  const FeaturedQuoteCard({
    Key? key,
    required this.quote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0x33C3A95E),
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
          // Quote text
          Padding(
            padding: EdgeInsets.only(bottom: 30.h, right: 30.w), // Added right padding to avoid overlap with bookmark
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (quote.text == 'featuredQuoteText' || quote.text.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: SizedBox(
                        width: 40.w,
                        height: 40.h,
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.white24,
                          rightDotColor: AppColors.googlebuttonColor,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    _getLocalized(context, quote.text),
                    style: AppFonts.manropeSemiBold(
                      fontSize: 16.sp,
                      color: const Color(0xFF1E1E1E),
                      height: 1.50,
                    ),
                  ),
                if (quote.author.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "- ${quote.author}",
                        style: TextStyle(
                          color: const Color(0xFF1E1E1E).withValues(alpha: 0.8),
                          fontSize: 12.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Subtitle with arrow icon
          Positioned(
            left: 50.w,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getLocalized(context, quote.subtitle),
                    style: AppFonts.manropeRegular(
                      fontSize: 12.sp,
                      color: const Color(0xFF5D4708),
                    ),
                  ),
                  // SizedBox(width: 4.w),

                ],
              ),
            ),
          ),

          // Bookmark icon at top right
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                final InspireController controller = Get.find<InspireController>();
                controller.toggleQuoteBookmark();
              },
              child: Obx(() {
                final InspireController controller = Get.find<InspireController>();
                return Icon(
                  controller.isQuoteBookmarked.value 
                      ? Icons.bookmark 
                      : Icons.bookmark_border,
                  color: const Color(0xFF5D4708),
                  size: 24.sp,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalized(BuildContext context, String key) {
    if (key == 'featuredQuoteText') {
      return AppLocalizations.of(context)!.featuredQuoteText;
    } else if (key == 'featuredQuoteSubtitle') {
      return AppLocalizations.of(context)!.featuredQuoteSubtitle;
    }
    return key;
  }
}