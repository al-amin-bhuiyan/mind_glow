import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import '../../controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';
import '../../controllers/inspire_controller/inspire_controller.dart';
import '../../utils/app_fonts.dart';
import '../../widgets/custom_assets.dart';
import '../../widgets/custom_nav_bar_widgets.dart';
import 'widgets/category_filter_chips.dart';
import 'widgets/featured_quote_card.dart';
import 'widgets/inspiration_card.dart';
import 'widgets/video_thumbnail_card.dart';

/// Inspire Screen - Displays inspirational content
/// Follows clean architecture and OOP principles
class InspireScreen extends StatelessWidget {
  InspireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get controllers
    final InspireController controller = Get.put(InspireController());
    final CustomNavBarController navBarController = Get.find<CustomNavBarController>();

    // Set nav bar to inspire tab (index 3)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navBarController.selectedIndex.value != 3) {
        navBarController.selectedIndex.value = 3;
      }
    });

    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            // Background image
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(CustomAssets.backgroundimage),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // Header section with back button and title
                    _buildHeader(context),

                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 26.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),

                            // Subtitle text
                            _buildSubtitle(context),

                            SizedBox(height: 16.h),

                            // Featured quote card
                            Obx(() => FeaturedQuoteCard(
                              quote: controller.featuredQuote.value,
                            )),

                            SizedBox(height: 24.h),

                            // What you've reflected on section
                            _buildReflectedOnSection(context, controller),

                            SizedBox(height: 20.h),

                            // Save Inspirations section
                            _buildSaveInspirationsSection(context, controller),

                            SizedBox(height: 20.h),

                            // Inspiration Video section
                            _buildInspirationVideoSection(context, controller),

                            SizedBox(height: 20.h),

                            // Bottom note
                            _buildBottomNote(context),

                            SizedBox(height: 100.h), // Space for nav bar
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: CustomNavBar(controller: navBarController),
      ),
    );
  }

  /// Build header with back button and title
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 8.h,
        left: 26.w,
        right: 26.w,
        bottom: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              // // Back button
              // GestureDetector(
              //   onTap: () {
              //     if (Navigator.canPop(context)) {
              //       Navigator.pop(context);
              //     }
              //   },
              //   child: Container(
              //     width: 30.w,
              //     height: 30.h,
              //     decoration: ShapeDecoration(
              //       color: Colors.black.withValues(alpha: 0.10),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(100.r),
              //       ),
              //     ),
              //     child: Icon(
              //       Icons.arrow_back,
              //       size: 16.sp,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),

              SizedBox(width: 73.w),

              // Title
              Text(
                AppLocalizations.of(context)!.inspireTitle,
                textAlign: TextAlign.center,
                style: AppFonts.poppinsSemiBold(
                  fontSize: 18.sp,
                  color: Colors.black,
                  height: 1.11,
                ),
              ),
            ],
          ),

          SizedBox(width: 60.w), // Spacer for alignment
        ],
      ),
    );
  }

  /// Build subtitle text
  Widget _buildSubtitle(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: Text(
        AppLocalizations.of(context)!.inspireSubtitle,
        textAlign: TextAlign.center,
        style: AppFonts.manropeRegular(
          fontSize: 14.sp,
          color: const Color(0xFF78706B),
        ),
      ),
    );
  }

  /// Build "What you've reflected on" section
  Widget _buildReflectedOnSection(BuildContext context, InspireController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title and subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 242.w,
              child: Text(
                AppLocalizations.of(context)!.whatYouReflectedOn,
                style: AppFonts.poppinsSemiBold(
                  fontSize: 18.sp,
                  color: const Color(0xFF1E1E1E),
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              AppLocalizations.of(context)!.chooseWhatFeelsMeaningful,
              style: AppFonts.manropeRegular(
                fontSize: 14.sp,
                color: const Color(0xFF78706B),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Category filter chips
        CategoryFilterChips(controller: controller),
      ],
    );
  }

  /// Build "Save Inspirations" section
  Widget _buildSaveInspirationsSection(BuildContext context, InspireController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title and subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.saveInspirations,
              style: AppFonts.poppinsSemiBold(
                fontSize: 18.sp,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              AppLocalizations.of(context)!.wordsYouChoseToKeep,
              style: AppFonts.manropeRegular(
                fontSize: 14.sp,
                color: const Color(0xFF78706B),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Inspiration cards grid
        Obx(() {
          final items = controller.savedInspirations;
          if (items.isEmpty) return const SizedBox.shrink();

          final itemCount = controller.showAllQuotes.value ? items.length : (items.length > 4 ? 4 : items.length);

          final rows = <Widget>[];
          for (int i = 0; i < itemCount; i += 2) {
            rows.add(
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: InspirationCard(
                          inspiration: items[i],
                          onTap: () => controller.openInspirationDetail(context, items[i]),
                          onBookmarkTap: () => controller.toggleBookmark(items[i].id),
                        ),
                      ),
                      SizedBox(width: 15.w), // Space between cards
                      if (i + 1 < itemCount)
                        Expanded(
                          child: InspirationCard(
                            inspiration: items[i + 1],
                            onTap: () => controller.openInspirationDetail(context, items[i + 1]),
                            onBookmarkTap: () => controller.toggleBookmark(items[i + 1].id),
                          ),
                        )
                      else
                        Expanded(child: const SizedBox()), // Placeholder to maintain constraints
                    ],
                  ),
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...rows,
              
              if (items.length > 4) ...[
                Center(
                  child: TextButton(
                    onPressed: controller.toggleShowAllQuotes,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF5D4708),
                    ),
                    child: Text(
                      controller.showAllQuotes.value 
                          ? 'Show less' 
                          : 'Show more',
                      style: AppFonts.manropeSemiBold(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ],
    );
  }

  /// Build "Inspiration Video" section
  Widget _buildInspirationVideoSection(BuildContext context, InspireController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title and subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.inspirationVideo,
              style: AppFonts.poppinsSemiBold(
                fontSize: 18.sp,
                color: const Color(0xFF1E1E1E),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              AppLocalizations.of(context)!.wordsYouChoseToKeep,
              style: AppFonts.manropeRegular(
                fontSize: 14.sp,
                color: const Color(0xFF78706B),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Video thumbnails grid
        Obx(() => Wrap(
          spacing: 4.w,
          runSpacing: 8.h,
          alignment: WrapAlignment.spaceBetween,
          children: controller.inspirationVideos.map((video) {
            return VideoThumbnailCard(
              video: video,
              onTap: () => controller.playVideo(context, video),
            );
          }).toList(),
        )),
      ],
    );
  }

  /// Build bottom note
  Widget _buildBottomNote(BuildContext context) {
    return SizedBox(
      width: 350.w,
      child: Text(
        AppLocalizations.of(context)!.inspireBottomNote,
        textAlign: TextAlign.center,
        style: AppFonts.manropeRegular(
          fontSize: 14.sp,
          color: const Color(0xFF78706B),
        ),
      ),
    );
  }
}