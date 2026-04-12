import 'dart:ui';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import 'package:mind_glow/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../controllers/journey_controller/journey_controller.dart';
import '../../../widgets/custom_assets.dart';

/// Reflection Card Widget - Displays individual reflection item
/// Follows OOP principles with proper encapsulation
class ReflectionCard extends StatefulWidget {
  final ReflectionItem reflection;
  final Future<void> Function() onTap;

  const ReflectionCard({
    Key? key,
    required this.reflection,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ReflectionCard> createState() => _ReflectionCardState();
}

class _ReflectionCardState extends State<ReflectionCard> {
  bool _isLoading = false;

  void _handleTap() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    
    try {
      await widget.onTap();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0x33C3A95E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19.r),
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container with vertical line
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIconContainer(),
                    SizedBox(width: 10.w),
                    _buildVerticalLine(),
                  ],
                ),

                SizedBox(width: 10.w),

                // Content
                Expanded(
                  child: _buildContent(context),
                ),
              ],
            ),
          ),
          // Inner shadow overlay
          Positioned.fill(
            child: IgnorePointer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.04),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.white.withValues(alpha: 0.02),
                      ],
                      stops: const [0.0, 0.25, 0.75, 1.0],
                    ),
                  ),
                  child: _isLoading
                      ? Center(
                          child: LoadingAnimationWidget.fourRotatingDots(
                            color: AppColors.googlebuttonColor,
                            size: 60,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build icon container
  Widget _buildIconContainer() {
    return Container(
      width: 30.w,
      height: 30.h,
      padding: EdgeInsets.all(3.w),
      decoration: ShapeDecoration(
        color: const Color(0x4CC3A95E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          CustomAssets.seven_reflections_written,
          width: 24.w,
          height: 24.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Build vertical line separator
  Widget _buildVerticalLine() {
    return Container(
      width: 1.w,
      height: 66.h,
      color: const Color(0x66845826),
    );
  }

  /// Build content section
  Widget _buildContent(BuildContext context) {
    if (widget.reflection.title.isEmpty) {
      return Container(
        height: 60.h,
        alignment: Alignment.center,
        child: SizedBox(
          width: 40.w,
          height: 40.h,
          child: LoadingAnimationWidget.inkDrop(
            color: AppColors.googlebuttonColor,
            size: 40,
          ),
        ),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title with date and theme - SemiBold
        Text(
          '${_getTranslated(context, widget.reflection.date)} :- ${_getTranslated(context, widget.reflection.title)}',
          style: TextStyle(
            color: const Color(0xFF1E1E1E),
            fontSize: 14.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600, // SemiBold
           // height:2.43.h,
          ),
        ),

        SizedBox(height: 4.h),

        // Description - Regular
        SizedBox(
          width: double.infinity,
          child: Text(
            _getTranslated(context, widget.reflection.summary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: const Color(0xFF1E1E1E),
              fontSize: 12.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400, // Regular
            ),
          ),
        ),
      ],
    );
  }

  String _getTranslated(BuildContext context, String key) {
     if (key.isEmpty) return key;
     final l10n = AppLocalizations.of(context)!;
     switch(key) {
       case 'april12': return l10n.april12;
       case 'selfConfident': return l10n.selfConfident;
       case 'relationships': return l10n.relationships;
       case 'mockDesc1': return l10n.mockDesc1;
       case 'mockDesc2': return l10n.mockDesc2;
       case 'mockDesc3': return l10n.mockDesc3;
       case 'mockDesc4': return l10n.mockDesc4;
       default: return key; // Fallback to raw API string if not found in locals
     }
  }
}