import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../widgets/custom_assets.dart';
import '../../../../widgets/custom_back_button.dart';
import 'notification_controller.dart';

/// Notification Screen - Displays notification settings
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

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

              // Notification Settings List
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        _buildNotificationsList(controller),
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
  Widget _buildAppBar(NotificationController controller,BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 16.h),
      child: Row(
        children: [
          CustomBackButton(onPressed: () => controller.goBack(context), width: 30, height: 30, backgroundColor: Colors.black.withValues(alpha: 0.10), borderRadius: 100, color: Colors.black, size: 24,),
          Expanded(
            child: Text(
              'Notification',
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

  /// Build Notifications List
  Widget _buildNotificationsList(NotificationController controller) {
    return Container(
      width: 350.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Receive notifications when new scenario arrived
          Obx(() => _buildNotificationItem(
            'Receive notifications when new scenario arrived',
            controller.receiveNewScenarios.value,
                (value) => controller.toggleNewScenarios(value),
          )),
          SizedBox(height: 16.h),

          // Notify me about practice reminder
          Obx(() => _buildNotificationItem(
            'Notify me about practice reminder',
            controller.practiceReminder.value,
                (value) => controller.togglePracticeReminder(value),
          )),
          SizedBox(height: 16.h),

          // Security alerts
          Obx(() => _buildNotificationItem(
            'Security alerts',
            controller.securityAlerts.value,
                (value) => controller.toggleSecurityAlerts(value),
          )),
          SizedBox(height: 16.h),

          // Push notifications
          Obx(() => _buildNotificationItem(
            'Push notifications',
            controller.pushNotifications.value,
                (value) => controller.togglePushNotifications(value),
          )),
          SizedBox(height: 16.h),

          // Email notifications
          Obx(() => _buildNotificationItem(
            'Email notifications',
            controller.emailNotifications.value,
                (value) => controller.toggleEmailNotifications(value),
          )),
        ],
      ),
    );
  }

  /// Build Notification Item
  Widget _buildNotificationItem(
      String title,
      bool isEnabled,
      Function(bool) onChanged,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: ShapeDecoration(
        color: const Color(0x33F0F0F0),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0x7FFEFEFE),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        shadows: const [
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
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.30,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          _buildCustomSwitch(isEnabled, onChanged),
        ],
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

