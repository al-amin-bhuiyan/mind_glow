import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import '../controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';
import 'custom_assets.dart';

/// Custom Navigation Bar Widget
/// OOP style implementation with clean separation of concerns
class CustomNavBar extends StatelessWidget {
  final CustomNavBarController controller;

  const CustomNavBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: double.infinity,
          height: 96.h,
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E8E3).withValues(alpha: 0.7),
            border: const Border(
              top: BorderSide(
                color: Colors.white10,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Navigation items row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _NavBarItem(
                    icon: CustomAssets.home_nav_bar,
                    hoverIcon: CustomAssets.home_hovar_nav_bar,
                    index: 0,
                    controller: controller,
                  ),
                  _NavBarItem(
                    icon: CustomAssets.reflect_nav_bar,
                    hoverIcon: CustomAssets.reflect_hovar_nav_bar,
                    index: 1,
                    controller: controller,
                  ),
                  _NavBarItem(
                    icon: CustomAssets.journey_nav_bar,
                    hoverIcon: CustomAssets.journey_hovar_nav_bar,
                    index: 2,
                    controller: controller,
                  ),
                  _NavBarItem(
                    icon: CustomAssets.inspire_nav_bar,
                    hoverIcon: CustomAssets.inspire_hovar_nav_bar,
                    index: 3,
                    controller: controller,
                  ),
                  _NavBarItem(
                    icon: CustomAssets.innerlearing_nav_bar,
                    hoverIcon: CustomAssets.innerlearing_hovar_nav_bar,
                    index: 4,
                    controller: controller,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual Navigation Bar Item
/// Private class following OOP encapsulation
class _NavBarItem extends StatelessWidget {
  final String icon;
  final String hoverIcon;
  final int index;
  final CustomNavBarController controller;

  const _NavBarItem({
    required this.icon,
    required this.hoverIcon,
    required this.index,
    required this.controller,
  });

  String _getLabel(BuildContext context, int index) {
    final loc = AppLocalizations.of(context)!;
    switch(index) {
      case 0: return loc.home;
      case 1: return loc.reflectTitle;
      case 2: return loc.journeyTabTitle;
      case 3: return loc.inspireTitle;
      case 4: return loc.innerLearningTitle;
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = _getLabel(context, index);
    
    return Obx(
          () {
        final isSelected = controller.isSelected(index);

        return GestureDetector(
          onTap: () => controller.changeIndex(index, context),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: 60.w, // Fixed width to prevent overflow
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon - Stack for selected and unselected states to prevent white flash
                SizedBox(
                  width: 56.w,
                  height: 28.h,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      // UNSELECTED STATE
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: isSelected ? 0.0 : 1.0,
                        child: SvgPicture.asset(
                          icon,
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      // SELECTED STATE (Hover Effect & Background)
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 150),
                        opacity: isSelected ? 1.0 : 0.0,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Background color effect
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              child: SvgPicture.asset(
                                CustomAssets.color_effect_nav_bar,
                                width: 56.w,
                                height: 38.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Foreground hover icon - centered
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 2.h,
                              child: Center(
                                child: hoverIcon.endsWith('.png')
                                    ? Image.asset(
                                        hoverIcon,
                                        width: 24.w,
                                        height: 24.h,
                                        fit: BoxFit.contain,
                                      )
                                    : SvgPicture.asset(
                                        hoverIcon,
                                        width: 24.w,
                                        height: 24.h,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                // Label with overflow handling
                SizedBox(
                  width: 60.w,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF1E1E1E)
                          : const Color(0xFF4F4F4F),
                      fontSize: 11.sp,
                      fontFamily: 'Inter',
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}