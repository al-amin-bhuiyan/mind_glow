import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// FAQ Item Widget - Displays a single expandable FAQ item
class FaqItemWidget extends StatelessWidget {
  /// The question text
  final String question;

  /// The answer text
  final String answer;

  /// Whether the item is expanded
  final bool isExpanded;

  /// Callback when the item is tapped
  final VoidCallback onTap;

  const FaqItemWidget({
    super.key,
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F1E8),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Header
            _buildQuestionHeader(),

            // Answer Section
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: _buildAnswerSection(),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }

  /// Build question header with expand/collapse icon
  Widget _buildQuestionHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      child: Row(
        children: [
          // Question Text
          Expanded(
            child: Text(
              question,
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Expand/Collapse Icon
          AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 24.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }

  /// Build answer section
  Widget _buildAnswerSection() {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xFFE0E0E0),
            margin: EdgeInsets.only(bottom: 12.h),
          ),

          // Answer Text
          Text(
            answer,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
