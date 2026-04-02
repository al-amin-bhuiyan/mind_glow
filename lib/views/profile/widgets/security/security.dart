import 'package:flutter/material.dart';
import '../../../../widgets/custom_back_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_assets.dart';
import 'security_controller.dart';

/// Security Screen - Displays security settings
class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SecurityController());

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

              // Security Settings List
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        _buildSecurityList(controller, context),
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
  Widget _buildAppBar(SecurityController controller,BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          CustomBackButton(onPressed: () => controller.goBack(context), width: 35, height: 35, backgroundColor: Colors.black.withValues(alpha: 0.10), borderRadius: 100, color: Colors.black, size: 28,),
          Expanded(
            child: Text(
              'Security',
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

  /// Build Security List
  Widget _buildSecurityList(SecurityController controller, BuildContext context) {
    return Container(
      width: 350.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Change Password
          _buildChangePasswordItem(controller, context),
          SizedBox(height: 16.h),

          // Login Activity
          Obx(() => _buildSwitchItem(
            'Login Activity',
            controller.loginActivity.value,
                (value) => controller.toggleLoginActivity(value),
          )),
          SizedBox(height: 16.h),

          // Email & Phone Verification
          Obx(() => _buildSwitchItem(
            'Email & Phone Verification',
            controller.emailPhoneVerification.value,
                (value) => controller.toggleEmailPhoneVerification(value),
          )),
          SizedBox(height: 16.h),

          // Delete Account
          _buildDeleteAccountItem(controller, context),
        ],
      ),
    );
  }

  /// Build Change Password Item
  Widget _buildChangePasswordItem(SecurityController controller, BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onChangePasswordTap(context),
      child: Container(
        width: double.infinity,
        height: 52.h,
        padding: EdgeInsets.all(12.w),
        decoration: ShapeDecoration(
          color: const Color(0x33F0F0F0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          shadows: [
            BoxShadow(
              color: Color(0x16FFBF00),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0CFFBF00),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x02FFBF00),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x00FFBF00),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Change Password',
                style: TextStyle(
                  color: const Color(0xFF1E1E1E),
                  fontSize: 14.sp,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  height: 1.05,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Switch Item
  Widget _buildSwitchItem(
      String title,
      bool isEnabled,
      Function(bool) onChanged,
      ) {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.all(12.w),
      decoration: ShapeDecoration(
        color: const Color(0x33F0F0F0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        shadows: [
          BoxShadow(
            color: Color(0x16FFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0CFFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x02FFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x00FFBF00),
            blurRadius: 1,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 14.sp,
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
                height: 1.05,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          _buildCustomSwitch(isEnabled, onChanged),
        ],
      ),
    );
  }

  /// Build Delete Account Item
  Widget _buildDeleteAccountItem(SecurityController controller, BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onDeleteAccountTap(context),
      child: Container(
        width: double.infinity,
        height: 48.h,
        padding: EdgeInsets.all(12.w),
        decoration: ShapeDecoration(
          color: const Color(0x33F0F0F0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          shadows: [
            BoxShadow(
              color: Color(0x16FFBF00),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x0CFFBF00),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x02FFBF00),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x00FFBF00),
              blurRadius: 1,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Delete Account',
                style: TextStyle(
                  color: const Color(0xFFEE6C61),
                  fontSize: 14.sp,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  height: 1.05,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Icon(
              Icons.delete,
              size: 24.sp,
              color: const Color(0xFFEE6C61),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Custom Switch
  Widget _buildCustomSwitch(bool isEnabled, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!isEnabled),
      child: Container(
        width: 37.w,
        height: 20.h,
        child: Stack(
          children: [
            // Background
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 37.w,
                height: 20.h,
                decoration: ShapeDecoration(
                  color: isEnabled
                      ? const Color(0xFF1A56DB)
                      : const Color(0xFF696969),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
              ),
            ),
            // Thumb
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: isEnabled ? 18.17.w : 2.5.w,
              top: 2.h,
              child: Container(
                width: 16.w,
                height: 16.h,
                decoration: ShapeDecoration(
                  color: isEnabled
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


