import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_fonts.dart';

class SuggestionChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SuggestionChip({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: const Color(0x33C3A95E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x1A896D16),
              blurRadius: 6,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: AppFonts.poppinsRegular(
                fontSize: 12.sp,
                color: Colors.black.withValues(alpha: 0.60),
                height: 1.20,
              ),
            ),
            SizedBox(width: 2.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 12.sp,
              color: Colors.black.withValues(alpha: 0.60),
            ),
          ],
        ),
      ),
    );
  }
}
