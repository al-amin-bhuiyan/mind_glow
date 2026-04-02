import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

/// Other Option Dialog - Custom dialog for handling "Other" selection
/// This dialog allows users to enter custom text or prefer not to say
class OtherOptionDialog extends StatefulWidget {
  final String title;
  final String? initialValue;
  final Function(String?) onSubmit;

  const OtherOptionDialog({
    Key? key,
    required this.title,
    this.initialValue,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<OtherOptionDialog> createState() => _OtherOptionDialogState();
}

class _OtherOptionDialogState extends State<OtherOptionDialog> {
  late final TextEditingController _textController;
  final RxBool _preferNotToSay = false.obs;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    // TODO: Add API call here to save custom response to backend
    // TODO: Add validation logic before submitting
    // TODO: Add error handling for API failures
    // TODO: Add loading state while API call is in progress

    String? submittedValue;

    // Determine the value to submit
    if (_preferNotToSay.value) {
      submittedValue = 'Prefer not to say';
    } else if (_textController.text.trim().isNotEmpty) {
      submittedValue = _textController.text.trim();
    } else {
      submittedValue = null;
    }

    // Close the dialog first
    Navigator.of(context).pop();

    // Submit the value
    widget.onSubmit(submittedValue);

    // Show success toast notification
    // if (submittedValue != null) {
    //   toastification.show(
    //     context: context,
    //     type: ToastificationType.success,
    //     style: ToastificationStyle.flat,
    //     title: const Text('Success'),
    //     description: const Text('Your response has been saved successfully!'),
    //     alignment: Alignment.bottomCenter,
    //     autoCloseDuration: const Duration(seconds: 2),
    //     backgroundColor: Colors.green,
    //     foregroundColor: Colors.white,
    //     icon: const Icon(Icons.check_circle, color: Colors.white),
    //     showProgressBar: false,
    //     closeOnClick: true,
    //     pauseOnHover: false,
    //     dragToClose: true,
    //   );
    //
    //   // TODO: After successful API call, you can add additional actions here:
    //   // - Update local storage/cache
    //   // - Trigger analytics event
    //   // - Sync with other parts of the app
    //   // - Show additional UI feedback
    // }
  }

  void _handleCancel() {
    // Close the dialog
    Navigator.of(context).pop();

    // Clear the selection
    widget.onSubmit(null);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blur backdrop with tap to dismiss
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              // Close dialog when tapping on backdrop
              Navigator.of(context).pop();
              widget.onSubmit(null);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
        // Dialog content
        Center(
          child: GestureDetector(
            onTap: () {
              // Prevent tap from propagating to backdrop
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 48.w,
                    maxHeight: MediaQuery.of(context).size.height - 80.h,
                  ),
                  padding: EdgeInsets.all(24.w),
                  decoration: ShapeDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 40,
                        offset: const Offset(0, 10),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          widget.title,
                          style: AppFonts.poppinsSemiBold(
                            fontSize: 16.sp,
                            color: const Color(0xFF2D2D2D),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Text Field
                        Obx(() => TextFormField(
                          controller: _textController,
                          enabled: !_preferNotToSay.value,
                          maxLines: 3,
                          style: AppFonts.poppinsRegular(
                            fontSize: 14.sp,
                            color: _preferNotToSay.value
                                ? const Color(0xFFCCCCCC)
                                : const Color(0xFF1E1E1E),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Please specify...',
                            hintStyle: AppFonts.poppinsRegular(
                              fontSize: 14.sp,
                              color: const Color(0xFFCCCCCC),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color(0xFF80869A),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                width: 1.5,
                                color: AppColors.googlebuttonColor,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            filled: _preferNotToSay.value,
                            fillColor: _preferNotToSay.value
                                ? const Color(0xFFF5F5F5)
                                : Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                          ),
                        )),

                        SizedBox(height: 16.h),

                        // Prefer not to say checkbox
                        Obx(() => InkWell(
                          onTap: () {
                            _preferNotToSay.value = !_preferNotToSay.value;
                            if (_preferNotToSay.value) {
                              _textController.clear();
                            }
                          },
                          borderRadius: BorderRadius.circular(8.r),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 20.w,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    color: _preferNotToSay.value
                                        ? AppColors.googlebuttonColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                      color: _preferNotToSay.value
                                          ? AppColors.googlebuttonColor
                                          : const Color(0xFF80869A),
                                      width: 2,
                                    ),
                                  ),
                                  child: _preferNotToSay.value
                                      ? Icon(
                                    Icons.check,
                                    size: 14.sp,
                                    color: Colors.white,
                                  )
                                      : null,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Prefer not to say',
                                  style: AppFonts.poppinsRegular(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF2D2D2D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),

                        SizedBox(height: 24.h),

                        // Action Buttons
                        Row(
                          children: [
                            // Cancel Button
                            Expanded(
                              child: GestureDetector(
                                onTap: _handleCancel,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: AppColors.googlebuttonColor,
                                      ),
                                      borderRadius: BorderRadius.circular(100.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    textAlign: TextAlign.center,
                                    style: AppFonts.poppinsMedium(
                                      fontSize: 14.sp,
                                      color: AppColors.googlebuttonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 12.w),

                            // OK Button
                            Expanded(
                              child: GestureDetector(
                                onTap: _handleSubmit,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  decoration: ShapeDecoration(
                                    color: AppColors.googlebuttonColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.r),
                                    ),
                                  ),
                                  child: Text(
                                    'OK',
                                    textAlign: TextAlign.center,
                                    style: AppFonts.poppinsMedium(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ), // Column
                  ), // SingleChildScrollView
                ), // Container
              ), // Material
            ), // Padding
          ), // GestureDetector
        ), // Center
      ], // Stack children
    ); // Stack
  }
}

/// Static method to show the dialog
Future<String?> showOtherOptionDialog({
  required BuildContext context,
  required String title,
  String? initialValue,
}) async {
  String? result;

  await showDialog(
    context: context,
    barrierDismissible: true, // Allow dismissing by tapping outside
    builder: (context) => OtherOptionDialog(
      title: title,
      initialValue: initialValue,
      onSubmit: (value) {
        result = value;
      },
    ),
  );

  return result;
}
