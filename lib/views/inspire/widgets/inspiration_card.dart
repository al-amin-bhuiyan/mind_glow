import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import '../../../controllers/inspire_controller/inspire_controller.dart';
import '../../../utils/app_fonts.dart';
import '../../../widgets/custom_assets.dart';

/// Inspiration Card Widget
/// Displays saved inspiration item with bookmark functionality
class InspirationCard extends StatelessWidget {
  final InspirationItem inspiration;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;

  const InspirationCard({
    Key? key,
    required this.inspiration,
    required this.onTap,
    required this.onBookmarkTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card container
          Container(
            width: 165.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type badge and bookmark icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Type badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: ShapeDecoration(
                        color: const Color(0x33896D16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      child: Text(
                        _getLocalized(context, inspiration.typeLabel),
                        textAlign: TextAlign.center,
                        style: AppFonts.manropeRegular(
                          fontSize: 9.sp,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                    ),

                    // Bookmark icon
                    GestureDetector(
                      onTap: onBookmarkTap,
                      child: SvgPicture.asset(
                        inspiration.isBookmarked
                            ? CustomAssets.book_mark_icon_marked
                            : CustomAssets.book_mark_icon_not_marked,
                        width: 16.w,
                        height: 16.h,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Title text
                Text(
                  _getLocalized(context, inspiration.title),
                  style: AppFonts.manropeRegular(
                    fontSize: 13.sp,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.h),

          // Saved context
          SizedBox(
            width: 165.w,
            child: Text(
              _getLocalized(context, inspiration.savedContext),
              style: AppFonts.manropeMedium(
                fontSize: 9.sp,
                color: const Color(0xFF78706B),
                height: 1.56,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalized(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch(key) {
      case 'typeQuote': return l10n.typeQuote;
      case 'typeRoleModels': return l10n.typeRoleModels;
      case 'mockInspireTitle': return l10n.mockInspireTitle;
      case 'mockContextPatience': return l10n.mockContextPatience;
      case 'mockContextQuiet': return l10n.mockContextQuiet;
      case 'mockContextAcceptance': return l10n.mockContextAcceptance;
      default: return key;
    }
  }
}