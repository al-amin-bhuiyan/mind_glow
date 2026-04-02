import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_assets.dart';
import '../../../../widgets/custom_back_button.dart';
import 'subscription_controller.dart';

/// Subscription Screen - Displays subscription plans
class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CustomAssets.backgroundimage),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            // Scrollable Content
            Positioned(
              left: 0,
              right: 0,
              top: 114.h,
              bottom: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  child: Column(
                    children: [
                      // Free Plan Card
                      _buildFreePlanCard(),

                      SizedBox(height: 16.h),

                      // Inner Plan Card
                      _buildInnerPlanCard(controller, context),

                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),

            // App Bar (Fixed at top)
            _buildAppBar(context, controller),
          ],
        ),
      ),
    );
  }

  /// Build App Bar
  Widget _buildAppBar(BuildContext context, SubscriptionController controller) {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFFFEF8F3)),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Status Bar Placeholder
              SizedBox(height: 8.h),

              // App Bar Content
              Container(
                width: double.infinity,
                height: 54.h,
                padding: EdgeInsets.only(
                  top: 8.h,
                  left: 26.w,
                  right: 26.w,
                  bottom: 16.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBackButton(onPressed: () => controller.goBack(context), width: 30, height: 30, backgroundColor: Colors.black.withValues(alpha: 0.10), borderRadius: 100, color: Colors.black, size: 24,),
                    Expanded(
                      child: Text(
                        'Subscription',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 30.w),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build Free Plan Card
  Widget _buildFreePlanCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF7EA),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16FFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0CFFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x02FFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x00FFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title and Price Section
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 318.w,
                  child: Text(
                    'MindGlow - Free',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF111928),
                      fontSize: 24.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  '\$0',
                  style: TextStyle(
                    color: const Color(0xFF111928),
                    fontSize: 32.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Features Section
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFeatureItem('Gentle reflective prompts'),
                      SizedBox(height: 16.h),
                      _buildFeatureItem('A quiet space to pause and reflect'),
                      SizedBox(height: 16.h),
                      _buildFeatureItem('Limited reflections per  week'),
                      SizedBox(height: 16.h),
                      _buildFeatureItem('Your recent reflections saved'),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Reflection should always remain accessible',
                  style: TextStyle(
                    color: const Color(0xFF111928),
                    fontSize: 15.sp,
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    height: 1.60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build Inner Plan Card
  Widget _buildInnerPlanCard(
      SubscriptionController controller,
      BuildContext context,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(CustomAssets.mindglow_inner_background),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x28A5A5A5),
            blurRadius: 50,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title and Pricing Section
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'MindGlow - Inner 🍃',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF1E1E1E),
                      fontSize: 24.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$8.99',
                            style: TextStyle(
                              color: const Color(0xFF1E1E1E),
                              fontSize: 18.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '/month',
                            style: TextStyle(
                              color: const Color(0xFF1E1E1E),
                              fontSize: 12.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                        color: const Color(0xCC1E1E1E),
                        fontSize: 14.sp,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$69',
                            style: TextStyle(
                              color: const Color(0xFF1E1E1E),
                              fontSize: 18.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: '/year',
                            style: TextStyle(
                              color: const Color(0xFF1E1E1E),
                              fontSize: 12.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '(gental continuty)',
                      style: TextStyle(
                        color: const Color(0xCC1E1E1E),
                        fontSize: 14.sp,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Features and Button Section
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInnerFeatureItem('Unlimited reflections'),
                            SizedBox(height: 16.h),
                            _buildInnerFeatureItem('Full reflection history'),
                            SizedBox(height: 16.h),
                            _buildInnerFeatureItem(
                              'Inner Learning - optional materials to explore ',
                            ),
                            SizedBox(height: 16.h),
                            _buildInnerFeatureItem(
                              'Reflective Dialogue (Advanced) deeper reflective respone, without direction',
                            ),
                            SizedBox(height: 16.h),
                            _buildInnerFeatureItem(
                              'Early access to new reflective experience',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Nothing is assigned. Nothing is required.',
                        style: TextStyle(
                          color: const Color(0xFF111928),
                          fontSize: 15.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w600,
                          height: 1.60,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),

                // Continue Button
                GestureDetector(
                  onTap: () => controller.continueWithPlan(context),
                  child: Container(
                    width: double.infinity,
                    height: 41.h,
                    padding: EdgeInsets.all(10.w),
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, 0.50),
                        end: Alignment(1.00, 0.50),
                        colors: [Color(0xFFA75711), Color(0xFFFFBD00)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Continue with MindGlow Inner',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build Feature Item for Free Plan
  Widget _buildFeatureItem(String text) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: SvgPicture.asset(
              CustomAssets.subscription_right_sign,
              width: 16.w,
              height: 16.h,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF111928),
                fontSize: 16.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build Inner Feature Item
  Widget _buildInnerFeatureItem(String text) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16.w,
            height: 16.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: SvgPicture.asset(
              CustomAssets.subscription_right_sign,
              width: 16.w,
              height: 16.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 16.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

