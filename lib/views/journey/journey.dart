import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';
import '../../controllers/journey_controller/journey_controller.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_nav_bar_widgets.dart';
import 'widgets/filter_button.dart';
import 'widgets/reflection_card.dart';
import 'widgets/stats_section.dart';

/// Journey Screen - Displays user's reflection journey
/// Follows clean architecture and OOP principles
class JourneyScreen extends StatelessWidget {
  JourneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get controllers
    final JourneyController controller = Get.put(JourneyController());
    final CustomNavBarController navBarController = Get.find<CustomNavBarController>();

    // Set nav bar to journey tab (index 2)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navBarController.selectedIndex.value != 2) {
        navBarController.selectedIndex.value = 2;
      }
    });

    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            // Background image
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(CustomAssets.backgroundimage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Column(
                  children: [
                    // Header section with back button and title
                    _buildHeader(context),

                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 26.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),

                            // Subtitle text
                            _buildSubtitle(),

                            SizedBox(height: 20.h),

                            // Stats section
                            StatsSection(controller: controller),

                            SizedBox(height: 20.h),

                            // Past reflections header with filter
                            _buildPastReflectionsHeader(controller),

                            SizedBox(height: 10.h),

                            // Reflection cards list
                            _buildReflectionsList(controller),

                            SizedBox(height: 20.h),

                            // Bottom note
                            _buildBottomNote(),

                            SizedBox(height: 100.h), // Space for nav bar
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomNavBar(controller: navBarController),
      ),
    );
  }

  /// Build header with back button and title
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFEF8F3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16FFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 50.w,
          right: 26.w,
          top: 8.h,
          bottom: 16.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   width: 30.w,
            //   height: 30.h,
            //   decoration: ShapeDecoration(
            //     color: Colors.black.withValues(alpha: 0.10),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(100.r),
            //     ),
            //   ),
            //   // child: IconButton(
            //   //   padding: EdgeInsets.zero,
            //   //   onPressed: () => context.pop(),
            //   //   icon: Icon(
            //   //     Icons.arrow_back,
            //   //     size: 20.sp,
            //   //     color: Colors.black,
            //   //   ),
            //   // ),
            // ),
            Expanded(
              child: Center(
                child: Text(
                  'Journey',
                  textAlign: TextAlign.center,
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 18.sp,
                    color: Colors.black,
                    height: 1.11,
                  ),
                ),
              ),
            ),
            SizedBox(width: 30.w), // Balance the back button
          ],
        ),
      ),
    );
  }

  /// Build subtitle text
  Widget _buildSubtitle() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'A quiet space holding your reflections, just as you shared them.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFF78706B),
          fontSize: 14.sp,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  /// Build past reflections header with filter button
  Widget _buildPastReflectionsHeader(JourneyController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Your past reflections',
          style: AppFonts.poppinsSemiBold(
            fontSize: 18.sp,
            color: const Color(0xFF1E1E1E),
          ),
        ),
        //  FilterButton(controller: controller),
      ],
    );
  }

  /// Build list of reflection cards
  Widget _buildReflectionsList(JourneyController controller) {
    return Obx(
          () => Column(
        children: controller.reflections
            .map((reflection) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: ReflectionCard(
            reflection: reflection,
            onTap: () => controller.openReflectionDetail(reflection),
          ),
        ))
            .toList(),
      ),
    );
  }

  /// Build bottom note text
  Widget _buildBottomNote() {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'You can return to any reflection whenever it feels right.',
        style: TextStyle(
          color: const Color(0xFF78706B),
          fontSize: 13.sp,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
