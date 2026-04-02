import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_assets.dart';
import '../../../../widgets/custom_back_button.dart';
import 'support_and_help_controller.dart';

/// Support and Help Screen - Displays help and support options
class SupportAndHelpScreen extends StatelessWidget {
  const SupportAndHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupportAndHelpController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CustomAssets.backgroundimage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              _buildAppBar(controller,context),

              // Support Options List
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        _buildSupportOptionsList(controller, context),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build App Bar
  Widget _buildAppBar(SupportAndHelpController controller,BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          CustomBackButton(
            onPressed: () => controller.goBack(context),
            width: 30,
            height: 30,
            backgroundColor: Colors.black.withValues(alpha: 0.10),
            borderRadius: 100,
            color: Colors.black,
            size: 24,
          ),
          Expanded(
            child: Text(
              'Help & Support',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.11,
              ),
            ),
          ),
          SizedBox(width: 30.w),
        ],
      ),
    );
  }

  /// Build Support Options List
  Widget _buildSupportOptionsList(SupportAndHelpController controller, BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FAQs
          _buildSupportItem(
            title: 'FAQs',
            onTap: () => controller.onFAQsTap(context),
          ),
          SizedBox(height: 16.h),

          // Contact Support
          _buildSupportItem(
            title: 'Contact Support',
            onTap: () => controller.onContactSupportTap(context),
          ),
          SizedBox(height: 16.h),

          // Privacy Policy
          _buildSupportItem(
            title: 'Privacy Policy',
            onTap: () => controller.onPrivacyPolicyTap(context),
          ),
          SizedBox(height: 16.h),

          // Terms & Conditions
          _buildSupportItem(
            title: 'Terms & Conditions',
            onTap: () => controller.onTermsAndConditionsTap(context),
          ),
        ],
      ),
    );
  }

  /// Build Support Item
  Widget _buildSupportItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height:  40.h,

        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0x33F0F0F0),
          borderRadius: BorderRadius.circular(8.r),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          boxShadow: [
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bullet Point
            Container(
              width: 8.w,
              height: 8.h,
              decoration: ShapeDecoration(
                color: const Color(0xFF1E1E1E),
                shape: OvalBorder(),
              ),
            ),
            SizedBox(width: 4.w),

            // Title
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
