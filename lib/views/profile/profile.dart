import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller/profile_controller.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_back_button.dart';
import '../../controllers/localization_controller/localization_controller.dart';

/// Profile Screen - User profile with settings and options
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
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

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        //  SizedBox(height: 16.h),

                        // Profile Header
                        _buildProfileHeader(controller),

                        SizedBox(height: 16.h),

                        // First Section (Edit Profile, Subscription, Notification)
                        _buildFirstSection(controller, context),

                        SizedBox(height: 16.h),

                        // Language Section
                        _buildLanguageSection(),

                        SizedBox(height: 16.h),

                        // Second Section (Security, Support & Help, Logout)
                        _buildSecondSection(controller, context),

                        SizedBox(height: 48.h),

                        // Logout Button
                        _buildLogoutButton(controller, context),

                        // SizedBox(height: 24.h),
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
  Widget _buildAppBar(BuildContext context, ProfileController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          // Back Button
          CustomBackButton(
            onPressed: () => controller.goBack(context),
            color: Colors.black,
            backgroundColor: Colors.black.withValues(alpha: 0.10),
            size: 24,
            width: 30.w,
            height: 30.h,
            borderRadius: 100.r,
          ),

          Expanded(
            child: Center(
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: AppFonts.poppinsSemiBold(
                  fontSize: 18.sp,
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

  /// Build Profile Header
  Widget _buildProfileHeader(ProfileController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 16.h, right: 16.w, bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Obx(
            () => Row(
          children: [
            // Profile Image
            Container(
              width: 84.w,
              height: 84.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.w,
                ),
                image: DecorationImage(
                  image: AssetImage(CustomAssets.person_image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // Name and Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.userName.value,
                  style: AppFonts.poppinsMedium(
                    fontSize: 20.sp,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  controller.userEmail.value,
                  style: AppFonts.poppinsRegular(
                    fontSize: 14.sp,
                    color: const Color(0x991E1E1E),
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build First Section
  Widget _buildFirstSection(ProfileController controller, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0x33C3A95E),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          // Edit Profile
          _buildMenuItem(
            icon: CustomAssets.edit_profile_svg,
            title: 'Edit Profile',
            onTap: () => controller.onEditProfileTap(context),
            showBorder: true,
          ),

          // Subscription
          _buildMenuItem(
            icon: CustomAssets.subscription_svg,
            title: 'Subscription',
            onTap: () => controller.onSubscriptionTap(context),
            showBorder: true,
          ),

          // Notification
          _buildMenuItem(
            icon: CustomAssets.notification_svg,
            title: 'Notification',
            onTap: () => controller.onNotificationTap(context),
            showBorder: false,
          ),
        ],
      ),
    );
  }

  /// Build Second Section
  Widget _buildSecondSection(ProfileController controller, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0x33C3A95E),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          // Security
          _buildMenuItem(
            icon: CustomAssets.security_svg,
            title: 'Security',
            onTap: () => controller.onSecurityTap(context),
            showBorder: true,
          ),

          // Support & Help
          _buildMenuItem(
            icon: CustomAssets.support_and_help_svg,
            title: 'Support & Help',
            onTap: () => controller.onSupportHelpTap(context),
            showBorder: true,
          ),

          // Logout
          _buildMenuItem(
            icon: CustomAssets.logout_svg,
            title: 'Logout',
            onTap: () => controller.onLogoutTap(context),
            showBorder: false,
          ),
        ],
      ),
    );
  }

  /// Build Language Section
  Widget _buildLanguageSection() {
    final locController = Get.find<LocalizationController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0x33C3A95E),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
            child: Text(
              "Language",
              style: AppFonts.poppinsSemiBold(fontSize: 16.sp, color: Colors.black),
            ),
          ),
          Obx(() {
            final current = locController.currentLocale.languageCode;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLangBtn('en', 'English', current, locController),
                _buildLangBtn('fr', 'Français', current, locController),
                _buildLangBtn('ar', 'العربية', current, locController),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLangBtn(String code, String label, String current, LocalizationController ctrl) {
    bool isSelected = current == code;
    return GestureDetector(
      onTap: () => ctrl.changeLanguage(code),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Text(
          label,
          style: AppFonts.poppinsMedium(
            fontSize: 12.sp,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  /// Build Menu Item
  Widget _buildMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    required bool showBorder,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Icon Container
                    Container(
                      width: 34.w,
                      height: 34.h,
                      decoration: BoxDecoration(
                        color: const Color(0x33FFBB00),
                        borderRadius: BorderRadius.circular(32.r),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          icon,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    ),

                    SizedBox(width: 16.w),

                    // Title
                    Text(
                      title,
                      style: AppFonts.poppinsMedium(
                        fontSize: 16.sp,
                        color: const Color(0xFF1E1E1E),
                        height: 1,
                      ),
                    ),
                  ],
                ),

                // Arrow Icon
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF1E1E1E),
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
        if (showBorder)
          Divider(
            color: Colors.white.withValues(alpha: 0.34),
            height: 1,
            thickness: 1,
          ),
      ],
    );
  }

  /// Build Logout Button
  Widget _buildLogoutButton(ProfileController controller, BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onLogoutButtonPress(context),
      child: Container(
        width: 350.w,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: const Color(0xFFC39D4C),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(
          child: Text(
            'Log Out',
            textAlign: TextAlign.center,
            style: AppFonts.poppinsMedium(
              fontSize: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}