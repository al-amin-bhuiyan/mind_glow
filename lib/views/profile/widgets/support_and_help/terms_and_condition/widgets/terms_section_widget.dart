import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../models/terms_condition_model.dart';

/// Terms Section Widget - Renders a terms & conditions section
class TermsSectionWidget extends StatelessWidget {
  /// The terms section to render
  final TermsConditionSection section;

  const TermsSectionWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    switch (section.type) {
      case TermsSectionType.heading:
        return _buildHeading();
      case TermsSectionType.paragraph:
        return _buildParagraph();
      case TermsSectionType.bulletList:
        return _buildBulletList();
      case TermsSectionType.mixed:
        return _buildMixed();
    }
  }

  /// Build heading section
  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.number.isNotEmpty)
          Text(
            '${section.number} ${section.title}',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          )
        else
          Text(
            section.title,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
      ],
    );
  }

  /// Build paragraph section
  Widget _buildParagraph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.number.isNotEmpty && section.title.isNotEmpty) ...[
          Text(
            '${section.number} ${section.title}',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          if (section.content.isNotEmpty) SizedBox(height: 8.h),
        ],
        if (section.content.isNotEmpty)
          Text(
            section.content,
            style: TextStyle(
              color: section.number.isEmpty
                  ? const Color(0xFF1E1E1E)
                  : Colors.black.withValues(alpha: 0.80),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
      ],
    );
  }

  /// Build bullet list section
  Widget _buildBulletList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        if (section.number.isNotEmpty && section.title.isNotEmpty) ...[
          Text(
            '${section.number} ${section.title}',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
        ],

        // Section description
        if (section.content.isNotEmpty) ...[
          Text(
            section.content,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8.h),
        ],

        // Bullet points
        if (section.bulletPoints != null)
          ...section.bulletPoints!.map((bullet) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildBulletPoint(bullet),
            );
          }),

        // Additional content after bullets
        if (section.additionalContent != null &&
            section.additionalContent!.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            section.additionalContent!,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.80),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }

  /// Build mixed section (bullets with complex additional content)
  Widget _buildMixed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        if (section.number.isNotEmpty && section.title.isNotEmpty) ...[
          Text(
            '${section.number} ${section.title}',
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
        ],

        // Section description
        if (section.content.isNotEmpty) ...[
          Text(
            section.content,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8.h),
        ],

        // Bullet points
        if (section.bulletPoints != null)
          ...section.bulletPoints!.map((bullet) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildBulletPoint(bullet),
            );
          }),

        // Additional complex content
        if (section.additionalContent != null &&
            section.additionalContent!.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Text(
            section.additionalContent!,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }

  /// Build single bullet point
  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.h, right: 8.w),
          child: Container(
            width: 4.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.80),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black.withValues(alpha: 0.80),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
