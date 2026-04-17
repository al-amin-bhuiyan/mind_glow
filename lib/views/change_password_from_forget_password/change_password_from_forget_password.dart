import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mind_glow/l10n/app_localizations.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../controllers/change_password_from_forget_password_controller/change_password_from_forget_password_controller.dart';

/// Change Password From Forget Screen
class ChangePasswordFromForgetScreen extends StatelessWidget {
  final String? email;
  final String? code;
  
  const ChangePasswordFromForgetScreen({super.key, this.email, this.code});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordFromForgetController());

    if (email != null && email!.isNotEmpty && code != null && code!.isNotEmpty) {
      controller.setCredentials(email!, code!);
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
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

              // Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        _buildPasswordFields(controller, context),
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
  Widget _buildAppBar(ChangePasswordFromForgetController controller, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
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
            child: Text(
              _getLocalized(context, 'resetPasswordTitle', 'Reset Password'),
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

  String _getLocalized(BuildContext context, String key, String fallback) {
    try {
      final localizations = AppLocalizations.of(context) as dynamic;
      switch (key) {
        case 'newPassword': return localizations.newPassword;
        case 'confirmPassword': return localizations.confirmPassword;
        case 'save': return localizations.save;
        case 'resetPasswordTitle': return localizations.resetPasswordTitle;
        default: return fallback;
      }
    } catch (_) {
      return fallback;
    }
  }

  /// Build Password Fields
  Widget _buildPasswordFields(ChangePasswordFromForgetController controller, BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // New Password
          Obx(() => _buildPasswordField(
            label: _getLocalized(context, 'newPassword', 'New Password'),
            controller: controller.newPasswordController,
            isVisible: controller.isNewPasswordVisible.value,
            onToggleVisibility: controller.toggleNewPasswordVisibility,
          )),
          SizedBox(height: 24.h),

          // Confirm Password
          Obx(() => _buildPasswordField(
            label: _getLocalized(context, 'confirmPassword', 'Confirm Password'),
            controller: controller.confirmPasswordController,
            isVisible: controller.isConfirmPasswordVisible.value,
            onToggleVisibility: controller.toggleConfirmPasswordVisibility,
          )),
          SizedBox(height: 36.h),

          // Save Button
          Obx(() => CustomButton(
            label: _getLocalized(context, 'save', 'Save'),
            onPressed: controller.isLoading.value
                ? null
                : () => controller.onSavePassword(context),
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
            color: const Color(0xFF80869A),
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