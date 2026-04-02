import 'package:mind_glow/routes/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_glow/l10n/app_localizations.dart';

import '../../controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';
import '../../controllers/home_controller/home_controller.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_nav_bar_widgets.dart';

/// Home Screen - Main dashboard with custom navigation bar
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final navBarController = Get.find<CustomNavBarController>();

    // Set nav bar to home tab (index 0)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navBarController.selectedIndex.value != 0) {
        navBarController.selectedIndex.value = 0;
      }
    });

    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CustomAssets.backgroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // Header Section
              _buildHeader(controller, context),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 10.h),
                        _buildGreeting(controller),
                        SizedBox(height: 16.h),
                        _buildReflectionCard(controller,context),
                        SizedBox(height: 24.h),
                        _buildQuestionCard(controller,context),
                        SizedBox(height: 24.h),
                        _buildJourneyCard(),
                        SizedBox(height: 100.h), // Space for nav bar
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomNavBar(controller: navBarController),
      ),
    );
  }

  /// Build header with title and profile icon
  Widget _buildHeader(HomeController controller, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(26.w, 8.h, 26.w, 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 20.w), // Spacer for centering
          Text(
            AppLocalizations.of(context)!.home,
            textAlign: TextAlign.center,
            style: AppFonts.poppinsSemiBold(
              fontSize: 18.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.push(AppPath.profile);
                },
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                  ),
                  child: SvgPicture.asset(
                    CustomAssets.profile_icon,
                    width: 30.w,
                    height: 30.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build greeting section
  Widget _buildGreeting(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
          'Good Morning ${controller.userName.value},',
          style: AppFonts.poppinsMedium(
            fontSize: 18.sp,
            color: const Color(0xFF292423),
          ),
        )),
        SizedBox(height: 2.h),
        Text(
          'A quiet space for reflection awaits you.',
          style: TextStyle(
            color: const Color(0xFF78706B),
            fontSize: 14.sp,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  /// Build reflection card
  Widget _buildReflectionCard(HomeController controller,BuildContext context)  {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: ShapeDecoration(
        color: const Color(0x33C3A95E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
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
          Text(
            'What feels present right now?',
            style: AppFonts.poppinsSemiBold(
              fontSize: 20.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            label: 'Start Reflections>',
            onPressed:()=> controller.onStartReflections(context),
            height: 44.h,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
            borderRadius: BorderRadius.circular(100.r),
          ),
        ],
      ),
    );
  }

  /// Build question card
  Widget _buildQuestionCard(HomeController controller,BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: ShapeDecoration(
        color: const Color(0x33C3A95E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
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
          Text(
            'A question you may wish to reflect on',
            style: AppFonts.poppinsMedium(
              fontSize: 16.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'When was the last time you felt truly confident — and what felt different in that moment?',
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.60),
              fontSize: 14.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            label: 'Start Session>',
            onPressed:()=> controller.onStartSession(context),
            height: 44.h,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
            borderRadius: BorderRadius.circular(100.r),
          ),
        ],
      ),
    );
  }

  /// Build journey card with stats
  Widget _buildJourneyCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: ShapeDecoration(
        color: const Color(0x33C3A95E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
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
          Text(
            'Your journey so far',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          SizedBox(height: 9.h),
          _buildJourneyStats(),
          SizedBox(height: 16.h),
          _buildInspirationCard(),
        ],
      ),
    );
  }

  /// Build journey stats row
  Widget _buildJourneyStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildStatItem(
          icon: CustomAssets.seven_reflections_written,
          text: '7 reflections\nwritten',
        ),
        SizedBox(width: 16.w),
        _buildStatItem(
          icon: CustomAssets.three_themes_explored,
          text: '3 themes\nexplored',
        ),
        SizedBox(width: 16.w),
        _buildStatItem(
          icon: CustomAssets.reflected_over_6_days,
          text: 'Reflected\nover 6 days',
        ),
      ],
    );
  }

  /// Build individual stat item
  Widget _buildStatItem({required String icon, required String text}) {
    return Row(
      children: [
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
          child: SvgPicture.asset(
            icon,
            width: 24.w,
            height: 24.h,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            color: const Color(0xFF1E1E1E),
            fontSize: 11.sp,
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  /// Build inspiration card
  Widget _buildInspirationCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: const Color(0x33C3A95E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x16FFBF00),
            blurRadius: 1,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0x33544005),
            blurRadius: 50,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A quiet inspiration',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 286.w,
            child: Text(
              'Growth begins when we notice what we usually overlook. Shown based on your preferences.',
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.60),
                fontSize: 14.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

