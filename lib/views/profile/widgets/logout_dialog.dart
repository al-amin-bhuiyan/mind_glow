import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/app_fonts.dart';
import '../../../widgets/custom_assets.dart';

/// Logout Confirmation Dialog
class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogoutConfirm;

  const LogoutDialog({
    Key? key,
    required this.onLogoutConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 350.w,
        padding: EdgeInsets.symmetric(horizontal: 75.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.50),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 199.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon and Title Section
                  Container(
                    width: 181.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Logout Icon
                        Container(
                          width: 46.w,
                          height: 46.h,
                          child: SvgPicture.asset(
                            CustomAssets.logout_dialog_icon_svg,
                            width: 46.w,
                            height: 46.h,
                          ),
                        ),

                        SizedBox(height: 8.h),

                        // Logout Text
                        SizedBox(
                          width: 181.w,
                          child: Text(
                            'Logout from the app   ?',
                            textAlign: TextAlign.center,
                            style: AppFonts.poppinsSemiBold(
                              fontSize: 18.h,
                              color: Colors.white,
                              height: 1.10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Log Out Button
                  GestureDetector(
                    onTap: onLogoutConfirm,
                    child: Container(
                      width: double.infinity,
                      height: 44.h,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xCC181A20),
                        border: Border.all(
                          width: 1,
                          color: Colors.white.withValues(alpha: 0.20),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Log Out',
                            style: AppFonts.poppinsRegular(
                              fontSize: 16.sp,
                              color: Colors.white,
                              height: 1,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
