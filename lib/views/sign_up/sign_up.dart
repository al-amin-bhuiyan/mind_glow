import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/sign_up_controller/sign_up_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignUpController>();

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

                    // Create Your Account text
                    Text(
                      'Create Your Account',
                      style: AppFonts.poppinsRegular(
                        fontSize: 18.sp,
                        color: const Color(0xFF666666),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Sign up heading
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign Up',
                        style: AppFonts.poppinsSemiBold(
                          fontSize: 24.sp,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Full Name Input Field
                    Obx(() => TextFormField(
                      controller: controller.fullNameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      style: AppFonts.poppinsRegular(
                        fontSize: 16.sp,
                        color: const Color(0xFF1E1E1E),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: AppFonts.poppinsRegular(
                          fontSize: 12.sp,
                          color: const Color(0xFF80869A),
                        ),
                        hintText: 'Your Name',
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
                              controller.isFullNameValid.value
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
                      validator: controller.fullNameValidator,
                    )),

                    SizedBox(height: 24.h),

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
                            width: 20.w,
                            height: 20.h,
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

                    SizedBox(height: 24.h),

                    // Password Input Field
                    Obx(() => TextFormField(
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible.value,
                      style: AppFonts.poppinsRegular(
                        fontSize: 16.sp,
                        color: const Color(0xFF1E1E1E),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: AppFonts.poppinsRegular(
                          fontSize: 12.sp,
                          color: const Color(0xFF80869A),
                        ),
                        hintText: '*******',
                        hintStyle: AppFonts.poppinsRegular(
                          fontSize: 16.sp,
                          color: const Color(0xFFCCCCCC),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF999999),
                            size: 24.w,
                          ),
                          onPressed: controller.togglePasswordVisibility,
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
                      validator: controller.passwordValidator,
                    )),

                    SizedBox(height: 24.h),

                    // Confirm Password Input Field
                    Obx(() => TextFormField(
                      controller: controller.confirmPasswordController,
                      obscureText: !controller.isConfirmPasswordVisible.value,
                      style: AppFonts.poppinsRegular(
                        fontSize: 16.sp,
                        color: const Color(0xFF1E1E1E),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: AppFonts.poppinsRegular(
                          fontSize: 14.sp,
                          color: const Color(0xFF80869A),
                        ),
                        hintText: '***********',
                        hintStyle: AppFonts.poppinsRegular(
                          fontSize: 16.sp,
                          color: const Color(0xFFCCCCCC),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isConfirmPasswordVisible.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: const Color(0xFF80869A),
                            size: 24.w,
                          ),
                          onPressed: controller.toggleConfirmPasswordVisibility,
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
                      validator: controller.confirmPasswordValidator,
                    )),

                    SizedBox(height: 40.h),

                    // Sign up Button
                    Obx(
                          () => CustomButton(
                        label: 'Sign up',
                        onPressed: () => controller.signUpWithEmail(context),
                        isLoading: controller.isLoading.value,
                        enabled: !controller.isLoading.value,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Already have an account? Sign In
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: AppFonts.poppinsRegular(
                            fontSize: 16.sp,
                            color: const Color(0xFF999999),
                          ),
                        ),
                        GestureDetector(
                          onTap: ()=>controller.navigateToSignIn(context),
                          child: Text(
                            'Sign In',
                            style: AppFonts.poppinsSemiBold(
                              fontSize: 16.sp,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Google and Apple Buttons
                    Row(
                      children: [
                        // Google Button
                        Expanded(
                          child: _SocialButton(
                            label: 'Google',
                            iconPath: CustomAssets.google,
                            onPressed: () => controller.signUpWithGoogle(context),
                          ),
                        ),

                        SizedBox(width: 16.w),

                        // Apple Button
                        Expanded(
                          child: _SocialButton(
                            label: 'Apple',
                            iconPath: CustomAssets.apple,
                            onPressed: () => controller.signUpWithApple(context),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 48.h),

                    // Powered by text
                    Text(
                      'Powered by The Reflectly Method',
                      style: AppFonts.poppinsRegular(
                        fontSize: 12.sp,
                        color: const Color(0xFF999999),
                      ),
                    ),

                    SizedBox(height: 24.h),
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

/// Custom Social Button Widget for Google and Apple
class _SocialButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        height: 52.h,
        decoration: ShapeDecoration(
          color: const Color(0x33C3A95E),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.black.withValues(alpha: 0.20),
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppFonts.poppinsMedium(
                fontSize: 16.sp,
                color: const Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
