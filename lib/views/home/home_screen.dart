import 'package:mind_glow/routes/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import 'package:mind_glow/utils/app_colors.dart';

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
                        _buildGreeting(controller, context),
                        SizedBox(height: 16.h),
                        _buildReflectionCard(controller,context),
                        SizedBox(height: 24.h),
                        _buildQuestionCard(controller,context),
                        SizedBox(height: 24.h),
                        _buildJourneyCard(controller, context),
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
  Widget _buildGreeting(HomeController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.userName.value.isEmpty) {
            return Row(
              children: [
                Text(
                  'Hello ',
                  style: AppFonts.poppinsMedium(
                    fontSize: 18.sp,
                    color: const Color(0xFF292423),
                  ),
                ),
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: LoadingAnimationWidget.progressiveDots(
                    color: AppColors.googlebuttonColor,
                    size: 24.r,
                  ),
                ),
                Text(
                  ' 👋',
                  style: AppFonts.poppinsMedium(
                    fontSize: 18.sp,
                    color: const Color(0xFF292423),
                  ),
                ),
              ],
            );
          }
          return Text(
            'Hello, ${controller.userName.value} 👋',
            style: AppFonts.poppinsMedium(
              fontSize: 18.sp,
              color: const Color(0xFF292423),
            ),
          );
        }),
        SizedBox(height: 2.h),
        Text(
          AppLocalizations.of(context)!.quietSpaceAwaits,
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
            AppLocalizations.of(context)!.whatFeelsPresent,
            style: AppFonts.poppinsSemiBold(
              fontSize: 20.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            label: AppLocalizations.of(context)!.startReflections,
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
            AppLocalizations.of(context)!.questionToReflect,
            style: AppFonts.poppinsMedium(
              fontSize: 16.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppLocalizations.of(context)!.reflectionQuestion,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.60),
              fontSize: 14.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.h),
          Obx(() {
            return CustomButton(
              label: AppLocalizations.of(context)!.startSession,
              onPressed: () => controller.onStartSession(context),
              height: 44.h,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
              ),
              borderRadius: BorderRadius.circular(100.r),
              isLoading: controller.isLoading.value,
              customLoadingWidget: LoadingAnimationWidget.fallingDot(
                color: Colors.white,
                size: 30,
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Build journey card with stats
  Widget _buildJourneyCard(HomeController controller, BuildContext context) {
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
            AppLocalizations.of(context)!.journeySoFar,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          SizedBox(height: 9.h),
          _buildJourneyStats(controller, context),
          SizedBox(height: 16.h),
          _buildInspirationCard(controller, context),
        ],
      ),
    );
  }

  /// Build journey stats row
  Widget _buildJourneyStats(HomeController controller, BuildContext context) {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildStatItem(
          icon: CustomAssets.seven_reflections_written,
          text: '${controller.reflectionsCount.value} reflections\nwritten',
        ),
        SizedBox(width: 16.w),
        _buildStatItem(
          icon: CustomAssets.three_themes_explored,
          text: '${controller.learningsCount.value} themes\nexplored',
        ),
        SizedBox(width: 16.w),
        _buildStatItem(
          icon: CustomAssets.reflected_over_6_days,
          text: 'Reflected\nover ${controller.activeReflectionDays.value} days',
        ),
      ],
    ));
  }

  /// Build individual stat item
  Widget _buildStatItem({required String icon, required String text}) {
    return Row(
      children: [
        Container(
          width: 28.w,
          height: 28.h,
          padding: EdgeInsets.all(1.w),
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
        SizedBox(width: 2.w),
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
  Widget _buildInspirationCard(HomeController controller, BuildContext context) {
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
            AppLocalizations.of(context)!.quietInspiration,
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
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.dailyQuote.value.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: SizedBox(
                        width: 40.w,
                        height: 40.h,
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.white24,
                          rightDotColor: AppColors.googlebuttonColor,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                else
                  Text(
                    controller.dailyQuote.value,
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: 0.60),
                      fontSize: 14.sp,
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                if (controller.dailyQuote.value.isNotEmpty && controller.quoteAuthor.value.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "- ${controller.quoteAuthor.value}",
                        style: TextStyle(
                          color: const Color(0xFF1E1E1E).withValues(alpha: 0.8),
                          fontSize: 12.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}