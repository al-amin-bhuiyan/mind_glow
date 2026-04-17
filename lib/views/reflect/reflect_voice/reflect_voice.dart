import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_assets.dart';
import '../../../widgets/custom_back_button.dart';
import 'reflect_voice_controller.dart';

/// Reflect Voice Screen - Voice recording with animated waveform
class ReflectVoiceScreen extends StatelessWidget {
  const ReflectVoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReflectVoiceController());

    return Scaffold(
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
          child: Column(
            children: [
              // App Bar
              _buildAppBar(context),

              // Main Content
              Expanded(
                child: Column(
                  children: [
                    // Greeting Text
                    Padding(
                      padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h),
                      child: _buildGreetingText(),
                    ),

                    // Spacer to push wave to bottom
                    const Spacer(),

                    // Wave Animation and Controls
                    _buildWaveSection(controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build App Bar
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          // Back Button
          CustomBackButton(
            onPressed: () => Navigator.of(context).pop(),
            width: 30,
            height: 30,
            backgroundColor: Colors.black.withValues(alpha: 0.10),
            borderRadius: 100,
            color: Colors.black,
            size: 24,
          ),

          // Title
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

          // Spacer to balance the back button
          SizedBox(width: 30.w),
        ],
      ),
    );
  }

  /// Build Greeting Text
  Widget _buildGreetingText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Hey there! I'm Sophia,",
        style: TextStyle(
          color: const Color(0xFF1E1E1E),
          fontSize: 18.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Build Wave Section with Animation and Controls
  Widget _buildWaveSection(ReflectVoiceController controller) {
    return SizedBox(
      width: double.infinity,
      height: 300.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Control Buttons
          Positioned(
            bottom: 90.h,
            child: Builder(
              builder: (context) => _buildControlButtons(controller, context),
            ),
          ),

          // Status Text
          Positioned(
            bottom: 30.h,
            child: Obx(() => Text(
              controller.statusText.value,
              style: TextStyle(
                color: Colors.black.withValues(alpha: 0.7),
                fontSize: 16.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
              ),
            )),
          ),
        ],
      ),
    );
  }

  /// Build Control Buttons
  Widget _buildControlButtons(ReflectVoiceController controller,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pause/Resume Button
        Obx(() => _buildCircleButton(
          icon: controller.isPaused.value ? Icons.play_arrow : Icons.pause,
          onTap: controller.togglePause,
        )),

        SizedBox(width: 30.w),

        // Microphone Button (Main)
        _buildMicButton(controller),

        SizedBox(width: 30.w),

        // Stop/Close Button
        _buildCircleButton(
          icon: Icons.close,
          onTap: ()=>controller.stopRecording(context),
        ),
      ],
    );
  }

  /// Build Circle Button
  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isMain = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isMain ? 64.w : 56.w,
        height: isMain ? 64.h : 56.h,
        decoration: BoxDecoration(
          color: AppColors.googlebuttonColor.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.googlebuttonColor.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: isMain ? 32.sp : 28.sp,
        ),
      ),
    );
  }

  /// Build Microphone Button
  Widget _buildMicButton(ReflectVoiceController controller) {
    return Obx(() {
      return GestureDetector(
        onTap: controller.toggleMic,
        child: SizedBox(
          width: 120.w,
          height: 120.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Mic Button (always visible, same color)
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: AppColors.googlebuttonColor.withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.googlebuttonColor.withValues(alpha: controller.isMicPressed.value ? 0.99 : 0.3),
                      blurRadius: controller.isMicPressed.value ? 25 : 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 32.sp,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
