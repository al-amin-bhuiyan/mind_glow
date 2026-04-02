import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controllers/journey_controller/journey_controller.dart';
import '../../../widgets/custom_assets.dart';

/// Stats Section Widget - Displays reflection statistics
/// Follows OOP principles with proper encapsulation
class StatsSection extends StatelessWidget {
  final JourneyController controller;

  const StatsSection({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Your reflections so far',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 9.h),

          // Inner container with border + shadow
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.w),
                decoration: ShapeDecoration(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                      color: const Color(0x33C3A95E), // border color
                      width: 2.5.h, // border width
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: const Color(0x33C3A95E).withValues(alpha: 0.35),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => _StatItem(
                      icon: CustomAssets.seven_reflections_written,
                      count: controller.reflectionsCount.value,
                      label: '7 reflections written',
                    )),
                    SizedBox(width: 3.w),
                    Obx(() => _StatItem(
                      icon: CustomAssets.three_themes_explored,
                      count: controller.themesExploredCount.value,
                      label: '3 themes explored',
                    )),
                    SizedBox(width: 3.w),
                    Obx(() => _StatItem(
                      icon: CustomAssets.reflected_over_6_days,
                      count: controller.reflectedDaysCount.value,
                      label: 'Reflected over 6 days',
                    )),
                  ],
                ),
              ),
              // Inner shadow overlay
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    margin: EdgeInsets.all(2.5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.05),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.02),
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}

/// Individual Stat Item Widget
/// Private class following OOP encapsulation
class _StatItem extends StatelessWidget {
  final String icon;
  final int count;
  final String label;

  const _StatItem({
    required this.icon,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circular icon container
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24.w,
                height: 24.h,
                child: SvgPicture.asset(
                  icon,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 4.w),

        // Text label
        SizedBox(
          width: 65.w,
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 11.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
