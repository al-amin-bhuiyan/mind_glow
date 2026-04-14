import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:info_popup/info_popup.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Card container
        Expanded(
          child: InfoPopupWidget(
            key: ValueKey(inspiration.id),
            customContent: () => Container(
              width: 250.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getLocalized(context, inspiration.title),
                    style: AppFonts.manropeMedium(
                      fontSize: 14.sp,
                      color: const Color(0xFF1E1E1E),
                      height: 1.5,
                    ),
                  ),
                  if (inspiration.author != null && inspiration.author!.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "- ${inspiration.author!}",
                        style: AppFonts.manropeBold(
                          fontSize: 12.sp,
                          color: const Color(0xFF5D4708),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            arrowTheme: const InfoPopupArrowTheme(
              color: Colors.white,
              arrowDirection: ArrowDirection.up,
            ),
            dismissTriggerBehavior: PopupDismissTriggerBehavior.anyWhere,
            areaBackgroundColor: Colors.transparent,
            child: Container(
              width: double.infinity,
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
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.manropeRegular(
                      fontSize: 13.sp,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  
                  if (inspiration.author != null && inspiration.author!.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Text(
                      "- ${inspiration.author!}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.manropeMedium(
                        fontSize: 11.sp,
                        color: const Color(0xFF5D4708),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),

        if (inspiration.savedContext.isNotEmpty) ...[
          SizedBox(height: 8.h),

          // Saved context
          SizedBox(
            width: double.infinity,
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
      ],
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