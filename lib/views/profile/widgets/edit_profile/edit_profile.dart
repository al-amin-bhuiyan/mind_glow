import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_fonts.dart';
import '../../../../widgets/custom_assets.dart';
import '../../../../widgets/custom_back_button.dart';
import '../../../../widgets/custom_button.dart';
import 'edit_profile_controller.dart';

/// Edit Profile Screen - User can edit their profile information
class EditProfileScreen extends StatelessWidget {
  final Map<String, dynamic>? extra;

  const EditProfileScreen({super.key, this.extra});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    // Initialize controller with route data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeWithData(extra);
    });

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
                        SizedBox(height: 24.h),

                        // Profile Image with Edit Button
                        _buildProfileImage(controller, context),

                        SizedBox(height: 32.h),

                        // Email Field
                        _buildTextField(
                          label: 'Email',
                          controller: controller.emailController,
                          hintText: 'emma.wilson@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 24.h),

                        // First Name Field
                        _buildTextField(
                          label: 'First Name',
                          controller: controller.firstNameController,
                          hintText: 'Emma',
                        ),

                        SizedBox(height: 24.h),

                        // Last Name Field
                        _buildTextField(
                          label: 'Last Name',
                          controller: controller.lastNameController,
                          hintText: 'Wilson',
                        ),

                        SizedBox(height: 24.h),

                        // Change Email Option
                        _buildChangeEmailOption(context),

                        SizedBox(height: 40.h),

                        // Save Button
                        _buildSaveButton(controller, context),

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
  Widget _buildAppBar(BuildContext context, EditProfileController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          // Back Button
          CustomBackButton(
            onPressed: () => controller.goBack(context),
            color: Colors.black,
            backgroundColor: Colors.black.withValues(alpha: 0.10),
            size: 24.sp,
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

  /// Build Profile Image with Edit Button
  Widget _buildProfileImage(EditProfileController controller, BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Profile Image
          Obx(
                () => Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.w,
                ),
                image: DecorationImage(
                  image: controller.selectedImage.value != null
                      ? FileImage(controller.selectedImage.value!)
                      : AssetImage(CustomAssets.person_image) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Edit Button Overlay
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => controller.showImagePickerOptions(context),
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFC39D4C),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.w,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build Text Field
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.poppinsSemiBold(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppFonts.poppinsRegular(
              fontSize: 16,
              color: Colors.black.withValues(alpha: 0.6),
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppFonts.poppinsRegular(
                fontSize: 16,
                color: Colors.black.withValues(alpha: 0.3),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: const Color(0xFFC39D4C),
                  width: 1.5,
                ),
              ),
              filled: false,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build Change Email Option
  Widget _buildChangeEmailOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement change email functionality
        print('Change Email tapped');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Change Email',
              style: AppFonts.poppinsRegular(
                fontSize: 16.sp,
                color: Colors.black.withValues(alpha: 0.6),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.black,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  /// Build Save Button
  Widget _buildSaveButton(EditProfileController controller, BuildContext context) {
    return Obx(
          () => CustomButton(
        label: 'Save',
        onPressed: () => controller.saveProfile(context),
        isLoading: controller.isLoading.value,
        width: double.infinity,
        height: 50.h,
        textStyle: AppFonts.poppinsSemiBold(
          fontSize: 16.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
