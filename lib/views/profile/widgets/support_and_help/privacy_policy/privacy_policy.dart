import 'package:flutter/material.dart';
import '../../../../../widgets/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../widgets/custom_assets.dart';
import 'privacy_policy_controller.dart';
import 'widgets/policy_section_widget.dart';

/// Privacy Policy Screen - Displays the app's privacy policy
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyPolicyController());

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
              _buildAppBar(controller, context),

              // Policy Content
              Expanded(
                child: Obx(() {
                  if (controller.sections.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: const Color(0xFFC39D4C),
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),

                        // Render all sections
                        ...controller.sections.map((section) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 24.h),
                            child: PolicySectionWidget(section: section),
                          );
                        }),

                        // Contact Email (after section 9)
                        _buildContactEmail(controller),

                        SizedBox(height: 32.h),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build App Bar
  Widget _buildAppBar(PrivacyPolicyController controller, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          CustomBackButton(onPressed: () => controller.goBack(context), width: 30, height: 30, backgroundColor: Colors.black.withValues(alpha: 0.10), borderRadius: 100, color: Colors.black, size: 24,),
          Expanded(
            child: Text(
              'Privacy Policy',
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

  /// Build Contact Email
  Widget _buildContactEmail(PrivacyPolicyController controller) {
    return Text(
      controller.contactEmail,
      style: TextStyle(
        color: const Color(0xFF1E1E1E),
        fontSize: 15.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
    );
  }
}



