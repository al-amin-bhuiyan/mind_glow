import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_fonts.dart';
import '../../../widgets/custom_assets.dart';
import '../../../widgets/custom_back_button.dart';
import 'relationship_learning_controller.dart';

class RelationshipLearningScreen extends StatelessWidget {
  const RelationshipLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RelationshipLearningController());

    return Scaffold(
      extendBody: true,
      body: Container(
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
              _buildAppBar(controller),

              // Non-scrollable Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //    SizedBox(height: 8.h),

                      // Title Section
                      _buildTitleSection(),

                      SizedBox(height: 24.h),

                      // Content Card (Scrollable inside)
                      Expanded(
                        child: _buildContentCard(),
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build custom app bar with back button
  Widget _buildAppBar(RelationshipLearningController controller) {
    return Builder(
      builder: (context) => Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 8.h,
          left: 26.w,
          right: 26.w,
          bottom: 24.h,
        ),
        child: Row(
          children: [
            CustomBackButton(
              onPressed: () => controller.goBack(context),
              backgroundColor: Colors.black.withValues(alpha: 0.10),
              color: Colors.black,
              size: 24,
              width: 30.w,
              height: 30.h,
              borderRadius: 100.r,
            ),
            SizedBox(width: 46.w),
            Expanded(
              child: Text(
                'Relationship Learning',
                textAlign: TextAlign.center,
                style: AppFonts.poppinsSemiBold(
                  fontSize: 16.5.sp,
                  color: Colors.black,
                  height: 1.11,
                ),
              ),
            ),
            SizedBox(width: 76.w), // Balance the back button width
          ],
        ),
      ),
    );
  }

  /// Build title section
  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learn About Relationships',
          style: AppFonts.poppinsMedium(
            fontSize: 18.sp,
            color: const Color(0xFF292423),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Build healthy, meaningful, and lasting connections with others.',
          style: AppFonts.manropeRegular(
            fontSize: 14.sp,
            color: const Color(0xFF78706B),
            height: 1.29,
          ),
        ),
      ],
    );
  }

  /// Build content card with relationship learning text
  Widget _buildContentCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFE0CFB3),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.50.w,
            color: Colors.black.withValues(alpha: 0.20),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x16FFBF00),
            blurRadius: 1,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0x0CFFBF00),
            blurRadius: 1,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0x02FFBF00),
            blurRadius: 1,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color(0x00FFBF00),
            blurRadius: 1,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Text(
          'Healthy relationships are built on trust, respect, understanding, and emotional safety. A strong connection does not mean there will be no disagreements — it means both people are willing to communicate openly and solve problems together.\n\n'
              'Good communication is the foundation of every meaningful relationship. It involves listening without judgment, expressing feelings honestly, and respecting each other\'s perspective. When both individuals feel heard and valued, the bond becomes stronger.\n\n'
              'Setting healthy boundaries is also important. Boundaries are not walls; they are guidelines that protect emotional well-being. They help both people understand what is acceptable and what is not.\n\n'
              'In any relationship, conflicts are normal. What truly matters is how those conflicts are handled. Responding with patience, empathy, and maturity helps maintain trust and emotional stability.\n\n'
              'A healthy relationship should make you feel supported, respected, and safe — not anxious or uncertain. Take time to reflect on the kind of connection you want in your life and whether your current relationships align with your values and emotional needs.',
          style: AppFonts.poppinsRegular(
            fontSize: 14.sp,
            color: Colors.black.withValues(alpha: 0.60),
            height: 1.70,
          ),
        ),
      ),
    );
  }
}
