import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_button.dart';

/// Example usage of CustomButton widget
class CustomButtonExample extends StatelessWidget {
  const CustomButtonExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Button Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Basic button
            CustomButton(
              label: 'Continue',
              onPressed: () {
                print('Button pressed');
              },
            ),
            SizedBox(height: 16.h),

            // Loading button
            CustomButton(
              label: 'Loading...',
              isLoading: true,
              onPressed: () {},
            ),
            SizedBox(height: 16.h),

            // Disabled button
            CustomButton(
              label: 'Disabled',
              enabled: false,
              onPressed: () {},
            ),
            SizedBox(height: 16.h),

            // Button with custom width and height
            CustomButton(
              label: 'Custom Size',
              width: 200.w,
              height: 56.h,
              onPressed: () {},
            ),
            SizedBox(height: 16.h),

            // Button with leading icon
            CustomButton(
              label: 'Start Conversation',
              leading: Icon(Icons.chat, color: Colors.white, size: 20.sp),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
