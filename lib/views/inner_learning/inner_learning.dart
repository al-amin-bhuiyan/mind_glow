import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:ui';
import 'package:mind_glow/l10n/app_localizations.dart';
import 'package:mind_glow/utils/app_colors.dart';
import '../../controllers/inner_learning_controller/inner_learning_controller.dart';
import '../../controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_nav_bar_widgets.dart';
import 'widgets/learning_card.dart';
import 'widgets/suggestion_chip.dart';

class InnerLearningScreen extends StatelessWidget {
  const InnerLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InnerLearningController(), permanent: false);
    final navBarController = Get.find<CustomNavBarController>();

    // Set nav bar to inner learning tab (index 4)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navBarController.selectedIndex.value != 4) {
        navBarController.selectedIndex.value = 4;
      }
    });

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Obx(() => Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(CustomAssets.backgroundimage),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Custom App Bar
                  _buildAppBar(context),

                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 26.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Subtitle
                          Text(
                            AppLocalizations.of(context)!.whatToLearnToday,
                            textAlign: TextAlign.center,
                            style: AppFonts.manropeRegular(
                              fontSize: 14.sp,
                              color: const Color(0xFF78706B),
                              height: 1.29,
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Past Learnings Section
                          _buildPastLearningsSection(controller),

                          SizedBox(height: 24.h),

                          // Suggestion Chips
                          _buildSuggestionChips(controller),

                          SizedBox(height: 180.h), // Space for search bar + nav bar
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (controller.isLoading.value)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.googlebuttonColor,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ),
        ],
      )),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search Input Section - Moves with keyboard
          AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.only(
              left: 26.w,
              right: 26.w,
              bottom: 8.h + keyboardHeight,
              top: 8.h,
            ),
            child: _buildInputSection(controller),
          ),

          // Navigation Bar - Hidden when keyboard is visible
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: keyboardHeight > 0 ? 0 : null,
            child: keyboardHeight > 0
                ? const SizedBox.shrink()
                : SafeArea(
              child: CustomNavBar(controller: navBarController),
            ),
          ),
        ],
      ),
    );
  }

  /// Build custom app bar
  Widget _buildAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 8.h,
        left: 26.w,
        right: 26.w,
        bottom: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.innerLearningTitle,
            textAlign: TextAlign.center,
            style: AppFonts.poppinsSemiBold(
              fontSize: 18.sp,
              color: Colors.black,
              height: 1.11,
            ),
          ),
        ],
      ),
    );
  }

  /// Build past learnings section
  Widget _buildPastLearningsSection(InnerLearningController controller) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.yourPastLearnings,
            style: AppFonts.poppinsSemiBold(
              fontSize: 18.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          SizedBox(height: 12.h),

          // Learning cards list
          Obx(() => AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            child: Column(
              children: controller.displayedLearnings
                  .map((learning) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: LearningCard(
                  learning: learning,
                  onTap: () => controller.openLearningDetail(learning, context),
                ),
              ))
                  .toList(),
            ),
          )),

          SizedBox(height: 8.h),

          // See More/Less button
          Obx(() {
            return GestureDetector(
              onTap: controller.toggleShowMore,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      controller.showAllLearnings.value 
                          ? AppLocalizations.of(context)!.seeLess 
                          : AppLocalizations.of(context)!.seeMore,
                      key: ValueKey<bool>(controller.showAllLearnings.value),
                      style: AppFonts.poppinsRegular(
                        fontSize: 14.sp,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        height: 1.20,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  SizedBox(
                    width: 22.w,
                    height: 22.h,
                    child: AnimatedBuilder(
                      animation: controller.seeMoreAnimationController,
                      builder: (context, child) {
                        return Lottie.asset(
                          'assets/lottie/see_more_toggle.json',
                          controller: controller.seeMoreAnimationController,
                          fit: BoxFit.contain,
                          // Prevent rebuild issues
                          frameRate: FrameRate.max,
                          // Handle errors gracefully
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to simple icon if Lottie fails to load
                            return Icon(
                              controller.showAllLearnings.value
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 16.sp,
                              color: Colors.black,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Build suggestion chips
  Widget _buildSuggestionChips(InnerLearningController controller) {
    return Builder(
      builder: (context) => Column(
        children: [
          SuggestionChip(
            text: AppLocalizations.of(context)!.suggestionRelationship,
            onTap: () => controller.onSuggestionTap(AppLocalizations.of(context)!.suggestionRelationship, context),
          ),
          SizedBox(height: 8.h),
          SuggestionChip(
            text: AppLocalizations.of(context)!.suggestionSelfReflection,
            onTap: () => controller.onSuggestionTap(AppLocalizations.of(context)!.suggestionSelfReflection, context),
          ),
          SizedBox(height: 8.h),
          SuggestionChip(
            text: AppLocalizations.of(context)!.suggestionSelfConfident,
            onTap: () => controller.onSuggestionTap(AppLocalizations.of(context)!.suggestionSelfConfident, context),
          ),
        ],
      ),
    );
  }

  /// Build input section with text field and send button
  Widget _buildInputSection(InnerLearningController controller) {
    return Builder(
      builder: (context) => Row(
        children: [
          // Input field
          Expanded(
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: ShapeDecoration(
                color: Colors.white, // Solid background so background is not seen
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.r),
                ),
                shadows: [
                  BoxShadow(
                    color: const Color(0x1A896D16),
                    blurRadius: 11,
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
              child: TextField(
                controller: controller.textController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => controller.sendLearningQuery(context),
                textAlignVertical: TextAlignVertical.top,
                style: AppFonts.poppinsRegular(
                  fontSize: 18.sp,
                  color: Colors.black.withValues(alpha: 0.99),
                ),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.inputHintRelationship,
                  hintStyle: AppFonts.poppinsRegular(
                    fontSize: 14.sp,
                    color: Colors.black.withValues(alpha: 0.50), // Standard soft hint color
                    height: 0.1,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Send button
          GestureDetector(
            onTap: () => controller.sendLearningQuery(context),
            child: Container(
              width: 50.w,
              height: 50.h,
              padding: EdgeInsets.all(8.w),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white, // Solid background so background is not seen
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.r),
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
              child: Center(
                child: SvgPicture.asset(
                  CustomAssets.send_icon,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}