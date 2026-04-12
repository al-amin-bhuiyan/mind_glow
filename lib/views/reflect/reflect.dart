import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_typing_indicator/flutter_typing_indicator.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import '../../controllers/reflect_controller/reflect_controller.dart';
import '../../controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_back_button.dart';

/// Reflect Screen - AI Chat Interface for Reflection
class ReflectScreen extends StatelessWidget {
  const ReflectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReflectController>();
    final navBarController = Get.find<CustomNavBarController>();

    // Set nav bar to reflect tab (index 1)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navBarController.selectedIndex.value != 1) {
        navBarController.selectedIndex.value = 1;
      }
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.goBack(context);
        }
      },
      child: Scaffold(
        body: Container(
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

                // Subtitle
                _buildSubtitle(context),

                // Chat Messages
                Expanded(
                  child: _buildMessagesList(controller),
                ),

                // Input Area
                _buildInputArea(controller,context),

                SizedBox(height: 16.h),

                // Navigation Bar
                //  CustomNavBar(controller: navBarController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build App Bar
  Widget _buildAppBar(BuildContext context, ReflectController controller) {
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
                AppLocalizations.of(context)!.reflectTitle,
                style: AppFonts.poppinsSemiBold(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Spacer for alignment
          SizedBox(width: 30.w),
        ],
      ),
    );
  }

  /// Build Subtitle
  Widget _buildSubtitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Text(
        AppLocalizations.of(context)!.reflectSubtitle,
        style: TextStyle(
          color: const Color(0xFF78706B),
          fontSize: 14.sp,
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  /// Build Messages List
  Widget _buildMessagesList(ReflectController controller) {
    return Obx(() {
      final itemCount = controller.messages.length + (controller.isLoading.value ? 1 : 0);
      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == controller.messages.length && controller.isLoading.value) {
            return _buildTypingBubble();
          }
          final message = controller.messages[index];
          final previousMessage = index > 0 ? controller.messages[index - 1] : null;

          final showDate = previousMessage == null ||
              message.timestamp.year != previousMessage.timestamp.year ||
              message.timestamp.month != previousMessage.timestamp.month ||
              message.timestamp.day != previousMessage.timestamp.day;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (showDate) _buildDateSeparator(message.timestamp),
              _buildMessageBubble(message),
            ],
          );
        },
      );
    });
  }

  /// Build Date Separator
  Widget _buildDateSeparator(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final formattedDate = '$day/$month/${date.year}';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: const Color(0xFFC3A95E).withValues(alpha: 0.3), thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              formattedDate,
              style: AppFonts.poppinsRegular(fontSize: 12.sp, color: const Color(0xFF78706B)),
            ),
          ),
          Expanded(child: Divider(color: const Color(0xFFC3A95E).withValues(alpha: 0.3), thickness: 1)),
        ],
      ),
    );
  }

  /// Build Typing Bubble
  Widget _buildTypingBubble() {
    return Padding(
      padding: EdgeInsets.only(bottom: 46.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Avatar
          Container(
            width: 32.w,
            height: 32.h,
            margin: EdgeInsets.only(right: 10.w),
            child: Center(
              child: SvgPicture.asset(
                CustomAssets.ai_voice_icon,
                width: 30.w,
                height: 30.h,
              ),
            ),
          ),

          // Message Bubble
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.00, 0.50),
                  end: Alignment(1.00, 0.50),
                  colors: [Color(0xFFA75711), Color(0xFFFFBD00)],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(4.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: TypingIndicator(
                backgroundColor: Colors.transparent,
                dotColor: Colors.white,
                dotSize: 6.sp,
                padding: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build Message Bubble
  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Avatar (left side for AI messages)
          if (!message.isUser) ...[
            Container(
              width: 32.w,
              height: 32.h,
              margin: EdgeInsets.only(right: 10.w),
              child: Center(
                child: SvgPicture.asset(
                  CustomAssets.ai_voice_icon,
                  width: 30.w,
                  height: 30.h,
                ),
              ),
            ),
          ],

          // Message Bubble
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: message.isUser
                        ? LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [const Color(0xFF2C2E2F), const Color(0xFF8B9195)],
                    )
                        : LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [const Color(0xFFA75711), const Color(0xFFFFBD00)],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: message.isUser ? Radius.circular(20.r) : Radius.circular(4.r),
                      bottomRight: message.isUser ? Radius.circular(4.r) : Radius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: AppFonts.poppinsRegular(
                      fontSize: 14.sp,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),
                if (message.isUser) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                    style: AppFonts.poppinsRegular(
                      fontSize: 10.sp,
                      color: const Color(0xFF78706B),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // User Avatar (right side for user messages)
          if (message.isUser) ...[
            Container(
              width: 32.w,
              height: 32.h,
              margin: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: AssetImage(CustomAssets.person_icon),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Build Input Area
  Widget _buildInputArea(ReflectController controller,BuildContext context) {
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
                      controller: controller.messageController,
                      style: AppFonts.poppinsRegular(
                        fontSize: 14.sp,
                        color: Colors.black.withValues(alpha: 0.60),
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.reflectInputHint,
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
                        controller.sendMessage();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Send Button inside text field
                  GestureDetector(
                    onTap: () {
                      controller.sendMessage();
                      FocusScope.of(context).unfocus();
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