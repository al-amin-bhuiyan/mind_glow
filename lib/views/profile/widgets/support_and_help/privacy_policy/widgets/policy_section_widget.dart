import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../models/privacy_policy_model.dart';

/// Policy Section Widget - Renders a privacy policy section
class PolicySectionWidget extends StatelessWidget {
  /// The privacy policy section to render
  final PrivacyPolicySection section;

  const PolicySectionWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    switch (section.type) {
      case SectionType.heading:
        return _buildHeading();
      case SectionType.paragraph:
        return _buildParagraph();
      case SectionType.bulletList:
        return _buildBulletList();
      case SectionType.richText:
        return _buildRichText();
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
          SizedBox(height: 8.h),
        ],
        if (section.content.isNotEmpty)
          Text(
            section.content,
            style: TextStyle(
              color: section.number.isEmpty
                  ? Colors.black.withValues(alpha: 0.80)
                  : const Color(0xFF1E1E1E),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: section.number.isEmpty
                  ? FontWeight.w400
                  : FontWeight.w400,
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
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
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
      ],
    );
  }

  /// Build single bullet point
  Widget _buildBulletPoint(BulletPoint bullet) {
    if (bullet.label.isEmpty) {
      // Simple bullet point without label
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
              bullet.description,
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

    // Bullet point with label and description
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
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${bullet.label} ',
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.80),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: bullet.isBold ? FontWeight.w500 : FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: bullet.description,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.80),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build rich text section
  Widget _buildRichText() {
    // For future implementation with complex rich text
    return _buildParagraph();
  }
}
