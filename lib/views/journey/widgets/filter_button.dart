import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/journey_controller/journey_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

/// Filter Button Widget - Displays filter button with bottom sheet
/// Follows OOP principles with proper encapsulation
class FilterButton extends StatelessWidget {
  final JourneyController controller;

  const FilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFilterBottomSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F0E8),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.googlebuttonColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Filter text
            Text(
              'Filter',
              style: AppFonts.interMedium(
                fontSize: 12,
                color: const Color(0xFF1E1E1E),
              ),
            ),

            SizedBox(width: 4.w),

            // Tune icon
            Icon(
              Icons.tune,
              size: 16.w,
              color: AppColors.googlebuttonColor,
            ),

            SizedBox(width: 4.w),

            // Selected filter text
            Obx(
                  () => Text(
                controller.selectedFilter.value,
                style: AppFonts.interSemiBold(
                  fontSize: 12,
                  color: AppColors.googlebuttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show filter bottom sheet
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _FilterBottomSheet(controller: controller),
    );
  }
}

/// Filter Bottom Sheet Widget
/// Private class following OOP encapsulation
class _FilterBottomSheet extends StatelessWidget {
  final JourneyController controller;

  const _FilterBottomSheet({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Filter by',
            style: AppFonts.poppinsSemiBold(
              fontSize: 18.sp,
              color: AppColors.blackColor,
            ),
          ),

          SizedBox(height: 16.h),

          // Filter options
          ...controller.filterOptions.map(
                (option) => _buildFilterOption(context, option),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// Build individual filter option
  Widget _buildFilterOption(BuildContext context, String option) {
    return Obx(
          () => InkWell(
        onTap: () {
          controller.applyFilter(option);
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: AppFonts.interMedium(
                    fontSize: 14.sp,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              if (controller.selectedFilter.value == option)
                Icon(
                  Icons.check,
                  color: AppColors.googlebuttonColor,
                  size: 24.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
