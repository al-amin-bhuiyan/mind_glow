import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import '../../../models/learning_model.dart';
import '../../../utils/app_fonts.dart';
import '../../../widgets/custom_assets.dart';

class LearningCard extends StatelessWidget {
  final LearningModel learning;
  final VoidCallback onTap;

  const LearningCard({
    super.key,
    required this.learning,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with vertical line
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container
                Container(
                  width: 30.w,
                  height: 30.h,
                  padding: EdgeInsets.all(3.w),
                  decoration: ShapeDecoration(
                    color: const Color(0x4CC3A95E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      CustomAssets.seven_reflections_written,
                      width: 24.w,
                      height: 24.h,
                      // colorFilter: const ColorFilter.mode(
                      //   Color(0xFF896D16),
                      //   BlendMode.srcIn,
                      // ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),

                // Vertical line
                Container(
                  width: 1.w,
                  height: 66.h,
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 1,
                        color: Color(0x66845826),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 10.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${learning.date.isNotEmpty ? learning.date : _getLocalized(context, learning.date)} :- ${learning.title.isNotEmpty ? _getLocalized(context, learning.title) : _getLocalized(context, learning.title)}',
                    style: AppFonts.poppinsSemiBold(
                      fontSize: 14.sp,
                      color: const Color(0xFF1E1E1E),
                      height: 1.43,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    learning.description.isNotEmpty 
                        ? learning.description.replaceAll('\n', ' ')
                        : _getLocalized(context, learning.description),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.manropeRegular(
                      fontSize: 12.sp,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLocalized(BuildContext context, String key) {
     final l10n = AppLocalizations.of(context)!;
     switch(key) {
       case 'april12': return l10n.april12;
       case 'april11': return l10n.april11;
       case 'april10': return l10n.april10;
       case 'learnAboutRelationships': return l10n.learnAboutRelationships;
       case 'learnAboutSelfReflection': return l10n.learnAboutSelfReflection;
       case 'learnAboutSelfConfident': return l10n.learnAboutSelfConfident;
       case 'learnAboutPatience': return l10n.learnAboutPatience;
       case 'learnAboutGrowth': return l10n.learnAboutGrowth;
       case 'mockDesc1': return l10n.mockDesc1;
       case 'mockDesc2': return l10n.mockDesc2;
       case 'mockDesc3': return l10n.mockDesc3;
       case 'mockDescPatience': return l10n.mockDescPatience;
       case 'mockDescGrowth': return l10n.mockDescGrowth;
       default: return key;
     }
  }
}