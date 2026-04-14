import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import '../../../utils/app_fonts.dart';
import '../../../widgets/custom_assets.dart';
import '../../../widgets/custom_back_button.dart';
import 'relationship_learning_controller.dart';
import '../../../models/learning_model.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class RelationshipLearningScreen extends StatelessWidget {
  const RelationshipLearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RelationshipLearningController());
    
    // Obtain incoming real API model or default
    final LearningModel? learningArgs = GoRouterState.of(context).extra as LearningModel?;

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
                      _buildTitleSection(context, learningArgs),

                      SizedBox(height: 24.h),

                      // Content Card (Scrollable inside)
                      Expanded(
                        child: _buildContentCard(context, learningArgs),
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
                AppLocalizations.of(context)!.relationshipLearningTitle,
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
  Widget _buildTitleSection(BuildContext context, LearningModel? learningArgs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkdownBody(
          data: '# ${learningArgs?.title ?? AppLocalizations.of(context)!.learnAboutRelationships}',
          styleSheet: MarkdownStyleSheet(
            h1: AppFonts.poppinsMedium(
              fontSize: 20.sp,
              color: const Color(0xFF292423),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          AppLocalizations.of(context)!.buildHealthyConnections,
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
  Widget _buildContentCard(BuildContext context, LearningModel? learningArgs) {
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
        child: MarkdownBody(
          data: learningArgs?.description ?? AppLocalizations.of(context)!.relationshipLearningContent,
          styleSheet: MarkdownStyleSheet(
            p: AppFonts.poppinsRegular(
              fontSize: 14.sp,
              color: Colors.black.withValues(alpha: 0.60),
              height: 1.70,
            ),
            h1: AppFonts.poppinsSemiBold(fontSize: 22.sp, color: Colors.black),
            h2: AppFonts.poppinsSemiBold(fontSize: 20.sp, color: Colors.black),
            h3: AppFonts.poppinsSemiBold(fontSize: 18.sp, color: Colors.black),
            listBullet: AppFonts.poppinsRegular(
              fontSize: 14.sp,
              color: Colors.black.withValues(alpha: 0.60),
            ),
          ),
        ),
      ),
    );
  }
}