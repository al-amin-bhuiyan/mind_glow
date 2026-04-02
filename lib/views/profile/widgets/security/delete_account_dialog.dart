import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/app_fonts.dart';

/// Delete Account Confirmation Dialog
/// Shows a confirmation dialog before deleting the user's account
class DeleteAccountDialog extends StatelessWidget {
  final VoidCallback onConfirmDelete;

  const DeleteAccountDialog({
    Key? key,
    required this.onConfirmDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 350.w,
        padding: EdgeInsets.symmetric(horizontal: 75.w, vertical: 24.h),
        decoration: ShapeDecoration(
          color: Colors.black.withValues(alpha: 0.20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
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
                        // Delete Icon
                        Container(
                          width: 46.w,
                          height: 46.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFED6B61),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 28.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),

                        // Title
                        SizedBox(
                          width: 181.w,
                          child: Text(
                            'Delete Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFED6B61),
                              fontSize: 18.sp,
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.w700,
                              height: 1.10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Delete Button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      onConfirmDelete();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFED6B61),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.white.withValues(alpha: 0.20),
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Delete Account',
                            style: AppFonts.poppinsRegular(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
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

  /// Static method to show the dialog
  static Future<void> show(
      BuildContext context, {
        required VoidCallback onConfirmDelete,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext context) {
        return DeleteAccountDialog(
          onConfirmDelete: onConfirmDelete,
        );
      },
    );
  }
}
