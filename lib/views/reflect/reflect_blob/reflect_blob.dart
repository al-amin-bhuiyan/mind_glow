import 'package:mind_glow/routes/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../controllers/reflect_controller/reflect_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../../widgets/custom_assets.dart';
import '../../../widgets/custom_back_button.dart';
import 'reflect_blob_controller.dart';

/// Reflect Blob Screen - Initial welcome screen with animated blob
class ReflectBlobScreen extends StatelessWidget {
  const ReflectBlobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReflectBlobController());
    final reflectController = Get.find<ReflectController>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                _buildAppBar(context, controller),

                // Welcome Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),  // Apply the padding here
                  child: _buildWelcomeText(),
                ),



                // Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                           SizedBox(height: 54.h),

                        // Animated Blob
                        _buildAnimatedBlob(controller),

                        // Question Text
                        _buildQuestionText(),

                        SizedBox(height: 174.h),
                      ],
                    ),
                  ),
                ),

                // Input Area
                _buildInputArea(reflectController,context),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build App Bar
  Widget _buildAppBar(BuildContext context, ReflectBlobController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          // Back Button
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
            child: Center(
              child: Text(
                'Reflect',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.11,
                ),
              ),
            ),
          ),

          SizedBox(width: 30.w),
        ],
      ),
    );
  }

  /// Build Welcome Text
  Widget _buildWelcomeText() {
    return Align(
      alignment: Alignment.topLeft, // You can adjust this to Center or any position
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 226.w,
            child: Text(
              'Welcome!',
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'This is a quiet space',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 22.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }


  /// Build Animated Blob
  Widget _buildAnimatedBlob(ReflectBlobController controller) {
    return SizedBox(
      width:double.infinity,
      height: 200.h,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColors.googlebuttonColor,
          size: 150.w,
        ),
      ),
    );
  }

  /// Build Question Text
  Widget _buildQuestionText() {
    return SizedBox(
      width: 199.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 199.w,
            child: Text(
              'What feels present for\nyou right now?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.44,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 199.w,
            child: Text(
              'Your Inner Light',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0x991E1E1E),
                fontSize: 12.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build Input Area (same as main reflect screen)
  Widget _buildInputArea(ReflectController controller,BuildContext context) {
    final blobController = Get.find<ReflectBlobController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w),
      child: Row(
        children: [
          // Text Input Field Container
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0x33C3A95E),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Row(
                children: [
                  // Text Input Field
                  Expanded(
                    child: TextField(
                      focusNode: blobController.inputFocusNode,
                      controller: controller.messageController,
                      style: AppFonts.poppinsRegular(
                        fontSize: 14.sp,
                        color: Colors.black.withValues(alpha: 0.60),
                      ),
                      decoration: InputDecoration(
                        hintText: 'I like working on the',
                        hintStyle: AppFonts.poppinsRegular(
                          fontSize: 14.sp,
                          color: Colors.black.withValues(alpha: 0.60),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) {
                        if (controller.messageController.text.trim().isNotEmpty) {
                          blobController.inputFocusNode.unfocus();
                          FocusScope.of(context).unfocus();
                          controller.sendMessage();
                          context.push('/reflect');
                        }
                      },
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Send Button inside text field
                  GestureDetector(
                    onTap: () {
                      // Send message and navigate to reflect screen
                      if (controller.messageController.text.trim().isNotEmpty) {
                        blobController.inputFocusNode.unfocus();
                        FocusScope.of(context).unfocus();
                        controller.sendMessage();
                        // Navigate to reflect screen
                        context.push(AppPath.reflect);
                      }
                    },
                    child: SvgPicture.asset(
                      CustomAssets.send_icon,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Voice Button
          GestureDetector(
            onTap: () => controller.toggleRecording(context),
            child: Obx(() => Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: controller.isRecording.value ? Colors.red.withValues(alpha: 0.3) : const Color(0x33C3A95E),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  CustomAssets.voice_icon,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.contain,
                  color: controller.isRecording.value ? Colors.red : null,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}