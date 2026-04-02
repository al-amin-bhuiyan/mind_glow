import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_path.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: CustomAssets.onBoardingImage1,
      title: 'MindGlow is a reflection space',
      description:
      'A place to pause, notice, and reconnect with yourself ',
    ),
    OnboardingData(
      image: CustomAssets.onBoardingImage2,
      title: 'MindGlow is a  reflection space',
      description:
      'When you’re ready,we’ll begin with a few gentle reflections. you can move at your place.',
    ),

  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Navigate to next screen (login or home)
      context.go(AppPath.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            CustomAssets.onboardingbackground,
            fit: BoxFit.cover,
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _pages.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _OnboardingPage(
                        data: _pages[index],
                        key: ValueKey(index),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    children: [
                      // Page indicator dots with animation
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubic,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: _currentPage == index ? 24.w : 8.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? const Color(0xFF2D2D2D)
                                  : const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: _currentPage == index
                                  ? [
                                BoxShadow(
                                  color: const Color(0xFF2D2D2D).withOpacity(0.3),
                                  blurRadius: 4.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ]
                                  : null,
                            ),
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOutCubic,
                              scale: _currentPage == index ? 1.1 : 1.0,
                              child: Container(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      // Continue button
                      CustomButton(
                        label: 'Continue >',
                        onPressed: _nextPage,
                        height: 56.h,
                      ),
                      SizedBox(height: 37.h),
                      Text(
                        "Powered by The Reflectify Method.",
                        textAlign: TextAlign.center,
                        style: AppFonts.poppinsRegular(
                          fontSize: 12.sp,
                          color: const Color(0xFF666666),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 10.h),




                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const _OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            // Image
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    data.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            SizedBox(height: 21.h),
            // Title
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: AppFonts.poppinsSemiBold(
                fontSize: 18.sp,
                color: const Color(0xFF2D2D2D),

              ),
            ),
            SizedBox(height: 8.h),
            // Description
            Text(
              data.description,
              textAlign: TextAlign.center,
              style: AppFonts.poppinsRegular(
                fontSize: 16.sp,
                color: const Color(0xFF666666),
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}

