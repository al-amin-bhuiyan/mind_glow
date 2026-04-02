import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/reset_password_controller/reset_password_controller.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();

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
                      height: 46.h,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 4.h),

                    // Forgot Password text
                    Text(
                      'Forgot Password',
                      style: AppFonts.poppinsRegular(
                        fontSize: 18.sp,
                        color: const Color(0xFF666666),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Description text
                    Text(
                      'Please enter your email to reset your password.',
                      textAlign: TextAlign.center,
                      style: AppFonts.poppinsRegular(
                        fontSize: 13.sp,
                        color: const Color(0xFF666666),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Email Input Field
                    Obx(() => TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,

                      style: AppFonts.poppinsRegular(
                        fontSize: 16.sp,
                        color: const Color(0xFF1E1E1E),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: AppFonts.poppinsRegular(
                          fontSize: 14.sp,
                          color: const Color(0xFF80869A),
                        ),
                        hintText: 'example@gmail.com',
                        hintStyle: AppFonts.poppinsRegular(
                          fontSize: 16.sp,
                          color: const Color(0xFFCCCCCC),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SvgPicture.asset(
                            CustomAssets.sign_icon,
                            width: 16.w,
                            height: 16.h,
                            colorFilter: ColorFilter.mode(
                              controller.isEmailValid.value
                                  ? Colors.green
                                  : const Color(0xFF1E1E1E),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFF80869A),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(
                            width: 1.5,
                            color: Color(0xFF80869A),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(
                            width: 1.5,
                            color: Colors.red,
                          ),
                        ),
                        filled: false,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 15.h,
                        ),
                      ),
                      validator: controller.emailValidator,
                    )),

                    SizedBox(height: 32.h),

                    // Send Code Button
                    Obx(
                          () => CustomButton(
                        label: 'Send Code',
                        onPressed: () => controller.sendResetCode(context),
                        isLoading: controller.isLoading.value,
                        enabled: !controller.isLoading.value,
                        height: 54.h,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.52),

                    // Powered by text
                    Text(
                      'Powered by The Reflectly Method.',
                      style: AppFonts.poppinsRegular(
                        fontSize: 12.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),

                    // SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}