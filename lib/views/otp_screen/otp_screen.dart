import 'package:mind_glow/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/otp_screen_controller/otp_screen_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  final String? email;

  const OtpScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OtpScreenController>();

    // Set email from route parameter
    if (email != null && email!.isNotEmpty) {
      controller.setEmail(email!);
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            CustomAssets.backgroundimage,
            fit: BoxFit.cover,
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 48.h),

                    // MindGlow Logo
                    Image.asset(
                      CustomAssets.mindglowlogo,
                      width: 180.w,
                      height: 40.h,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 4.h),

                    // Reset Password text
                    Text(
                      'Reset Password',
                      style: AppFonts.poppinsRegular(
                        fontSize: 18.sp,
                        color: const Color(0xFF666666),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Description text with email
                    Obx(() => RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppFonts.poppinsRegular(
                          fontSize: 13.sp,
                          color: const Color(0xFF666666),
                        ),
                        children: [
                          const TextSpan(text: 'We sent a 6-digit code to '),
                          TextSpan(
                            text: controller.userEmail.value.isNotEmpty
                                ? controller.userEmail.value
                                : 'youremail@.com',
                            style: AppFonts.poppinsSemiBold(
                              fontSize: 13.sp,
                              color: const Color(0xFF666666),
                            ),
                          ),
                          const TextSpan(text: '\nEnter the 6-digit code from the email.'),
                        ],
                      ),
                    )),

                    SizedBox(height: 32.h),

                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildOtpField(controller.otp1Controller, controller.otp1FocusNode, 1, controller.otp1, controller, context),
                        _buildOtpField(controller.otp2Controller, controller.otp2FocusNode, 2, controller.otp2, controller, context),
                        _buildOtpField(controller.otp3Controller, controller.otp3FocusNode, 3, controller.otp3, controller, context),
                        _buildOtpField(controller.otp4Controller, controller.otp4FocusNode, 4, controller.otp4, controller, context),
                        _buildOtpField(controller.otp5Controller, controller.otp5FocusNode, 5, controller.otp5, controller, context),
                        _buildOtpField(controller.otp6Controller, controller.otp6FocusNode, 6, controller.otp6, controller, context),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Paste Code Button
                    GestureDetector(
                      onTap: () => controller.handlePasteFromClipboard(context),
                      child: Text(
                        'Paste Code',
                        style: AppFonts.poppinsSemiBold(
                          fontSize: 14.sp,
                          color: AppColors.googlebuttonColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Verify Code Button
                    Obx(
                          () => CustomButton(
                        label: 'Verify Code >',
                        onPressed: () => controller.verifyCode(context),
                        isLoading: controller.isLoading.value,
                        enabled: !controller.isLoading.value,
                        height: 54.h,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Resend Email text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Haven't got the email? ",
                          style: AppFonts.poppinsRegular(
                            fontSize: 14.sp,
                            color: const Color(0xFF666666),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.resendCode(context),
                          child: Text(
                            'Resend Email',
                            style: AppFonts.poppinsSemiBold(
                              fontSize: 14.sp,
                              color: const Color(0xFF1E1E1E),
                              decoration: TextDecoration.underline, // Add underline here
                            ),
                          ),
                        )

                      ],
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.42),

                    // Powered by text
                    Text(
                      'Powered by The Reflectly Method.',
                      style: AppFonts.poppinsRegular(
                        fontSize: 12.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),

                    //    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual OTP input field
  Widget _buildOtpField(
      TextEditingController controller,
      FocusNode focusNode,
      int index,
      RxString observableValue,
      OtpScreenController otpController,
      BuildContext context,
      ) {
    return Obx(() {
      // Check if the field has input from observable state
      final hasInput = observableValue.value.isNotEmpty;

      return Container(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: hasInput ? AppColors.googlebuttonColor : Colors.black,
            width: 1,
          ),
        ),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: AppFonts.poppinsSemiBold(
            fontSize: 20.sp,
            color: const Color(0xFF1E1E1E),
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1), // STRICT: Only 1 digit per field
          ],
          onChanged: (value) {
            // Handle single digit entry or backspace
            if (value.length <= 1) {
              otpController.onOtpChanged(value, index, context);
            }
          },
        ),
      );
    });
  }
}
