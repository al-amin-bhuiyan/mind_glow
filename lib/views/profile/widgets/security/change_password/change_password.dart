import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../widgets/custom_assets.dart';
import '../../../../../widgets/custom_back_button.dart';
import '../../../../../widgets/custom_button.dart';
import 'change_password_controller.dart';

/// Change Password Screen - Allows users to change their password
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

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

              // Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        _buildPasswordFields(controller),
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
  Widget _buildAppBar(ChangePasswordController controller,BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          CustomBackButton(onPressed: () => controller.goBack(context), width: 30, height: 30, backgroundColor: Colors.black.withValues(alpha: 0.10), borderRadius: 100, color: Colors.black, size: 24,),
          Expanded(
            child: Text(
              'Change Pass',
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

  /// Build Password Fields
  Widget _buildPasswordFields(ChangePasswordController controller) {
    return Container(
      width: 350.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Password
          Obx(() => _buildPasswordField(
            label: 'Current Password',
            controller: controller.currentPasswordController,
            isVisible: controller.isCurrentPasswordVisible.value,
            onToggleVisibility: controller.toggleCurrentPasswordVisibility,
          )),
          SizedBox(height: 24.h),

          // New Password
          Obx(() => _buildPasswordField(
            label: 'New Password',
            controller: controller.newPasswordController,
            isVisible: controller.isNewPasswordVisible.value,
            onToggleVisibility: controller.toggleNewPasswordVisibility,
          )),
          SizedBox(height: 24.h),

          // Confirm Password
          Obx(() => _buildPasswordField(
            label: 'Confirm Password',
            controller: controller.confirmPasswordController,
            isVisible: controller.isConfirmPasswordVisible.value,
            onToggleVisibility: controller.toggleConfirmPasswordVisibility,
          )),
          SizedBox(height: 36.h),

          // Save Button
          Obx(() => CustomButton(
            label: 'Save',
            onPressed: controller.isLoading.value
                ? null
                : controller.onSavePassword,
            isLoading: controller.isLoading.value,
          )),
        ],
      ),
    );
  }

  /// Build Password Field
  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      style: TextStyle(
        fontSize: 16.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
        color: const Color(0xFF1E1E1E),
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: const Color(0xFF80869A),
        ),
        hintText: '**********',
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          color: const Color(0xFFCCCCCC),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Color(0xFF80869A),
            size: 20.w,
          ),
          onPressed: onToggleVisibility,

        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.googlebuttonColor,
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
    );
  }
}

