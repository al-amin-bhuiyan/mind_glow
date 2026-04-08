import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import '../../../controllers/inspire_controller/inspire_controller.dart';
import '../../../utils/app_fonts.dart';

/// Category Filter Chips Widget
/// Displays horizontal scrollable category filter chips
class CategoryFilterChips extends StatelessWidget {
  final InspireController controller;

  const CategoryFilterChips({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.categories.map((categoryKey) {
          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Obx(() => _CategoryChip(
              label: _getLocalizedCategory(context, categoryKey),
              isSelected: controller.selectedCategory.value == categoryKey,
              onTap: () => controller.selectCategory(categoryKey),
            )),
          );
        }).toList(),
      ),
    );
  }

  String _getLocalizedCategory(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;
    switch(key) {
      case 'categoryVoices': return l10n.categoryVoices;
      case 'categoryMeaning': return l10n.categoryMeaning;
      case 'categoryPerspectives': return l10n.categoryPerspectives;
      case 'categoryWhatMatters': return l10n.categoryWhatMatters;
      default: return key;
    }
  }
}

/// Individual Category Chip Widget
class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 6.h),
        decoration: ShapeDecoration(
          color: const Color(0x33896D16),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: const Color(0x66896D16),
            ),
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppFonts.manropeSemiBold(
            fontSize: 9.sp,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ),
    );
  }
}