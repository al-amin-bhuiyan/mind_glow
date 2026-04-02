import 'package:mind_glow/widgets/custom_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers/journey_controller/journey_controller.dart';
import '../../../widgets/custom_assets.dart';

/// Reflection Card Widget - Displays individual reflection item
/// Follows OOP principles with proper encapsulation
class ReflectionCard extends StatelessWidget {
  final ReflectionItem reflection;
  final VoidCallback onTap;

  const ReflectionCard({
    Key? key,
    required this.reflection,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 94.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0x33C3A95E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19.r),
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container with vertical line
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIconContainer(),
                    SizedBox(width: 10.w),
                    _buildVerticalLine(),
                  ],
                ),

                SizedBox(width: 10.w),

                // Content
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
          // Inner shadow overlay
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.04),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.02),
                    ],
                    stops: const [0.0, 0.25, 0.75, 1.0],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build icon container
  Widget _buildIconContainer() {
    return Container(
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
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Build vertical line separator
  Widget _buildVerticalLine() {
    return Container(
      width: 1.w,
      height: 66.h,
      color: const Color(0x66845826),
    );
  }

  /// Build content section
  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with date and theme - SemiBold
        Text(
          '${reflection.date} :- ${reflection.theme}',
          style: TextStyle(
            color: const Color(0xFF1E1E1E),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600, // SemiBold
            height: 1.43,
          ),
        ),

        SizedBox(height: 4.h),

        // Description - Regular
        SizedBox(
          width: double.infinity,
          child: Text(
            reflection.description,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 12.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400, // Regular
            ),
          ),
        ),
      ],
    );
  }
}
