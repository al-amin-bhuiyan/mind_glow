import 'package:mind_glow/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mind_glow/l10n/app_localizations.dart';
import 'package:mind_glow/views/inner_connection/widgets/other_option_dialog.dart';
import '../../../controllers/inner_connection_controller/inner_connection_controller.dart';
import '../../../utils/app_fonts.dart';
import '../../../widgets/custom_assets.dart';
import '../../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';

String _getTranslatedOption(BuildContext context, String option) {
  final loc = AppLocalizations.of(context)!;
  switch(option) {
    case 'She/Her': return loc.optSheHer;
    case 'He/Him': return loc.optHeHim;
    case 'Not to say': return loc.optNotToSay;
    case 'Under 18 years': return loc.optUnder18;
    case '18-24': return loc.opt18_24;
    case '25-34': return loc.opt25_34;
    case '35-44': return loc.opt35_44;
    case '45-64': return loc.opt45_64;
    case '65+': return loc.opt65Plus;
    case 'Single': return loc.optSingle;
    case 'Married': return loc.optMarried;
    case 'In a Relationship': return loc.optInRelationship;
    case 'Separated / Divorced': return loc.optSeparatedDivorced;
    case 'Widowed': return loc.optWidowed;
    case 'Student': return loc.optStudent;
    case 'Working professional': return loc.optWorkingProfessional;
    case 'Parent / caregiver': return loc.optParentCaregiver;
    case 'Self-employed / Building something': return loc.optSelfEmployed;
    case 'Retired': return loc.optRetired;
    case 'Busy / overwhelming': return loc.optBusyOverwhelming;
    case 'Stable but heavy': return loc.optStableHeavy;
    case 'Balanced': return loc.optBalanced;
    case 'Uncertain': return loc.optUncertain;
    case 'Mindfulness': return loc.optMindfulness;
    case 'Quiet but disconnected': return loc.optQuietDisconnected;
    case 'Christianity': return loc.optChristianity;
    case 'Islam': return loc.optIslam;
    case 'Judaism': return loc.optJudaism;
    case 'Buddhism': return loc.optBuddhism;
    case 'Hinduism': return loc.optHinduism;
    case 'Another faith or spiritual path': return loc.optAnotherFaith;
    case 'I prefer non-religious inspiration': return loc.optNonReligious;
    case 'Sacred or spiritual texts': return loc.optSacredTexts;
    case 'Spiritual teachers or scholars': return loc.optSpiritualTeachers;
    case 'Public figures or role models': return loc.optPublicFigures;
    case 'Writers or books': return loc.optWritersBooks;
    case 'Artists, creators, or influencers': return loc.optArtistsCreators;
    case 'Name specific people, books, or voices': return loc.optNameSpecific;
    case 'Something I\'ve been carrying': return loc.optSomethingCarrying;
    case 'A feeling I don\'t fully understand': return loc.optFeelingNotUnderstand;
    case 'A situation in my life': return loc.optSituationInLife;
    case 'A pattern I\'ve noticed': return loc.optPatternNoticed;
    case 'I don\'t know yet €” I just want space': return loc.optDontKnowWantSpace;
    case 'Other': return loc.optOther;
    default: return option;
  }
}

/// Inner Connection Screen - 8 pages questionnaire
class InnerConnectionScreen extends StatelessWidget {
  const InnerConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InnerConnectionController());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            CustomAssets.backgroundimage,
            fit: BoxFit.cover,
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // Top section with back button and progress
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Column(
                    children: [
                      // Back button and progress indicator
                      Row(
                        children: [
                          // Back button
                          Container(
                            width: 30.w,
                            height: 30.h,
                            child: CustomBackButton(
                              onPressed: () {
                                final currentPageValue = controller.currentPage.value;
                                if (currentPageValue == 0) {
                                  context.pop();
                                } else {
                                  controller.previousPage();
                                }
                              },
                              width: 30.w,
                              height: 30.h,
                              backgroundColor: Colors.black.withValues(alpha: 0.19),
                              borderRadius: 100.r,
                              color: const Color(0xFF2D2D2D),
                              size: 24.sp,
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                                width: 1.w,
                              ),
                            ),
                          ),
                          // Progress indicator (show only for pages 0-7)
                          Obx(() => controller.currentPage.value <= 7
                              ? Expanded(
                            child: Center(
                              child: Text(
                                '${controller.currentPage.value + 1}/8',
                                style: AppFonts.poppinsSemiBold(
                                  fontSize: 18.sp,
                                  color: const Color(0xFF2D2D2D),
                                ),
                              ),
                            ),
                          )
                              : const SizedBox.shrink()),
                        ],
                      ),
                      // Progress bar (show only for pages 0-7)
                      Obx(() => controller.currentPage.value <= 7
                          ? Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: controller.getProgress(),
                            backgroundColor: const Color(0xFFE0E0E0),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF2D2D2D),
                            ),
                            minHeight: 4.h,
                          ),
                        ),
                      )
                          : const SizedBox.shrink()),
                    ],
                  ),
                ),
                // Page content
                Expanded(
                  child: Obx(() {
                    switch (controller.currentPage.value) {
                      case 0:
                        return FullNamePage(controller: controller);
                      case 1:
                        return AgeRangePage(controller: controller);
                      case 2:
                        return LifeSituationPage(controller: controller);
                      case 3:
                        return LifeStagePage(controller: controller);
                      case 4:
                        return LifeFeelingPage(controller: controller);
                      case 5:
                        return FaithPage(controller: controller);
                      case 6:
                        return InspirationSourcePage(controller: controller);
                      case 7:
                        return AttentionAreaPage(controller: controller);
                      default:
                        return const SizedBox.shrink();
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== PAGE 0: FULL NAME AND PRONOUNS (1/8) ====================
class FullNamePage extends StatelessWidget {
  final InnerConnectionController controller;

  const FullNamePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              100.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(context)!.aMomentToNotice,
                  style: AppFonts.poppinsMedium(
                    fontSize: 14.sp,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 24.h),
                // Name Input Field with floating label
                TextFormField(
                  controller: controller.fullNameController,
                  onChanged: (value) => controller.updateFullName(value),
                  style: AppFonts.poppinsRegular(
                    fontSize: 16.sp,
                    color: const Color(0xFF1E1E1E),
                  ),
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.fullNameLabel,
                    labelStyle: AppFonts.poppinsRegular(
                      fontSize: 12.sp,
                      color: const Color(0xFF80869A),
                    ),
                    hintText: AppLocalizations.of(context)!.yourNameHint,
                    hintStyle: AppFonts.poppinsRegular(
                      fontSize: 16.sp,
                      color: const Color(0xFFCCCCCC),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(
                        width: 1.w,
                        color: const Color(0xFF80869A),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(
                        width: 1.5.w,
                        color: const Color(0xFF80869A),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(
                        width: 1.w,
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: BorderSide(
                        width: 1.5.w,
                        color: Colors.red,
                      ),
                    ),
                    filled: false,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 15.h,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                // Pronoun buttons
                Row(
                  children: controller.pronounOptions.map((pronoun) {
                    return Obx(() {
                      final isSelected = controller.selectedPronoun.value == pronoun;
                      return Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: _PronounButton(
                            text: _getTranslatedOption(context, pronoun),
                            isSelected: isSelected,
                            onTap: () => controller.selectPronoun(pronoun),
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
                const Spacer(),
                Obx(() => CustomButton(
                  label: AppLocalizations.of(context)!.continueBtn,
                  onPressed: controller.canContinue() ? controller.nextPage : null,
                  enabled: controller.canContinue(),
                )),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.poweredByReflectly,
                  style: AppFonts.poppinsRegular(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== PAGE 1: AGE RANGE (2/8) ====================
class AgeRangePage extends StatelessWidget {
  final InnerConnectionController controller;

  const AgeRangePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Text(
            AppLocalizations.of(context)!.ageRangeQuestion,
            style: AppFonts.poppinsSemiBold(
              fontSize: 18.sp,
              color: const Color(0xFF2D2D2D),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          Column(
            children: controller.ageRangeOptions.map((option) {
              return Obx(() {
                final isSelected = controller.selectedAgeRange.value == option;
                return _OptionButton(
                  text: _getTranslatedOption(context, option),
                  isSelected: isSelected,
                  onTap: () => controller.selectAgeRange(option),
                );
              });
            }).toList(),
          ),
          Spacer(),
          Obx(() => CustomButton(
            label: AppLocalizations.of(context)!.continueBtn,
            onPressed: controller.canContinue() ? controller.nextPage : null,
            enabled: controller.canContinue(),
          )),
          SizedBox(height: 21.h),
          Text(
            AppLocalizations.of(context)!.poweredByReflectly,
            style: AppFonts.poppinsRegular(
              fontSize: 12.sp,
              color: const Color(0xFF999999),
            ),
          ),
          SizedBox(height: 13.h),
        ],
      ),
    );
  }
}

// ==================== PAGE 2: LIFE SITUATION (3/8) ====================
class LifeSituationPage extends StatelessWidget {
  final InnerConnectionController controller;

  const LifeSituationPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              100.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.lifeSituationQuestion,
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 18.sp,
                    color: const Color(0xFF2D2D2D),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Column(
                  children: controller.lifeSituationOptions.map((option) {
                    return Obx(() {
                      final isSelected = controller.selectedLifeSituation.value == option;
                      return _OptionButton(
                        text: _getTranslatedOption(context, option),
                        isSelected: isSelected,
                        onTap: () async {
                          if (option == 'Other') {
                            final customValue = await showOtherOptionDialog(
                              context: context,
                              title: AppLocalizations.of(context)!.lifeSituationQuestion,
                              initialValue: controller.customLifeSituation.value,
                            );
                            controller.setCustomLifeSituation(customValue);
                          } else {
                            controller.selectLifeSituation(option);
                          }
                        },
                      );
                    });
                  }).toList(),
                ),
                const Spacer(),
                Obx(() => CustomButton(
                  label: AppLocalizations.of(context)!.continueBtn,
                  onPressed: controller.canContinue() ? controller.nextPage : null,
                  enabled: controller.canContinue(),
                )),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.poweredByReflectly,
                  style: AppFonts.poppinsRegular(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== PAGE 2: LIFE STAGE (4/8) ====================
class LifeStagePage extends StatelessWidget {
  final InnerConnectionController controller;

  const LifeStagePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              100.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.lifeStageQuestion,
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 18.sp,
                    color: const Color(0xFF2D2D2D),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Column(
                  children: controller.lifeStageOptions.map((option) {
                    return Obx(() {
                      final isSelected = controller.selectedLifeStage.value == option;
                      return _OptionButton(
                        text: _getTranslatedOption(context, option),
                        isSelected: isSelected,
                        onTap: () async {
                          if (option == 'Other') {
                            final customValue = await showOtherOptionDialog(
                              context: context,
                              title: AppLocalizations.of(context)!.lifeStageQuestion,
                              initialValue: controller.customLifeStage.value,
                            );
                            controller.setCustomLifeStage(customValue);
                          } else {
                            controller.selectLifeStage(option);
                          }
                        },
                      );
                    });
                  }).toList(),
                ),
                const Spacer(),
                Obx(() => CustomButton(
                  label: AppLocalizations.of(context)!.continueBtn,
                  onPressed: controller.canContinue() ? controller.nextPage : null,
                  enabled: controller.canContinue(),
                )),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.poweredByReflectly,
                  style: AppFonts.poppinsRegular(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== PAGE 3: LIFE FEELING (5/8) ====================
class LifeFeelingPage extends StatelessWidget {
  final InnerConnectionController controller;

  const LifeFeelingPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              100.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.aSpaceToExplore,
                  style: AppFonts.poppinsRegular(
                    fontSize: 14.sp,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 29.h),
                Text(
                  AppLocalizations.of(context)!.lifeFeelingQuestion,
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 18.sp,
                    color: const Color(0xFF2D2D2D),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Column(
                  children: controller.lifeFeelingOptions.map((option) {
                    return Obx(() {
                      final isSelected = controller.selectedLifeFeeling.value == option;
                      return _OptionButton(
                        text: _getTranslatedOption(context, option),
                        isSelected: isSelected,
                        onTap: () async {
                          if (option == 'Other') {
                            final customValue = await showOtherOptionDialog(
                              context: context,
                              title: AppLocalizations.of(context)!.lifeFeelingQuestion,
                              initialValue: controller.customLifeFeeling.value,
                            );
                            controller.setCustomLifeFeeling(customValue);
                          } else {
                            controller.selectLifeFeeling(option);
                          }
                        },
                      );
                    });
                  }).toList(),
                ),
                const Spacer(),
                Obx(() => CustomButton(
                  label: AppLocalizations.of(context)!.continueBtn,
                  onPressed: controller.canContinue() ? controller.nextPage : null,
                  enabled: controller.canContinue(),
                )),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.poweredByReflectly,
                  style: AppFonts.poppinsRegular(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== PAGE 4: FAITH (6/8) ====================
class FaithPage extends StatelessWidget {
  final InnerConnectionController controller;

  const FaithPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              100.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.anIdeaToSitWith,
                  style: AppFonts.poppinsRegular(
                    fontSize: 14.sp,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(context)!.faithQuestion,
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 16.sp,
                    color: const Color(0xFF2D2D2D),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Column(
                  children: controller.faithOptions.map((option) {
                    return Obx(() {
                      final isSelected = controller.selectedFaith.value == option;
                      return _OptionButton(
                        text: _getTranslatedOption(context, option),
                        isSelected: isSelected,
                        onTap: () async {
                          if (option == 'Other') {
                            final customValue = await showOtherOptionDialog(
                              context: context,
                              title: AppLocalizations.of(context)!.faithQuestion,
                              initialValue: controller.customFaith.value,
                            );
                            controller.setCustomFaith(customValue);
                          } else {
                            controller.selectFaith(option);
                          }
                        },
                      );
                    });
                  }).toList(),
                ),
                const Spacer(),
                Obx(() => CustomButton(
                  label: AppLocalizations.of(context)!.continueBtn,
                  onPressed: controller.canContinue() ? controller.nextPage : null,
                  enabled: controller.canContinue(),
                )),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.poweredByReflectly,
                  style: AppFonts.poppinsRegular(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== PAGE 5: INSPIRATION SOURCE (7/8) ====================
class InspirationSourcePage extends StatelessWidget {
  final InnerConnectionController controller;

  const InspirationSourcePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              100.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.anIdeaToSitWith,
                  style: AppFonts.poppinsRegular(
                    fontSize: 14.sp,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(context)!.inspirationQuestion,
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 18.sp,
                    color: const Color(0xFF2D2D2D),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Column(
                  children: controller.inspirationSourceOptions.map((option) {
                    return Obx(() {
                      final isSelected = controller.selectedInspirationSource.value == option;
                      return _OptionButton(
                        text: _getTranslatedOption(context, option),
                        isSelected: isSelected,
                        onTap: () => controller.selectInspirationSource(option),
                      );
                    });
                  }).toList(),
                ),
                const Spacer(),
                Obx(() => CustomButton(
                  label: AppLocalizations.of(context)!.continueBtn,
                  onPressed: controller.canContinue() ? controller.nextPage : null,
                  enabled: controller.canContinue(),
                )),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.poweredByReflectly,
                  style: AppFonts.poppinsRegular(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== PAGE 6: ATTENTION AREA (8/8) ====================
class AttentionAreaPage extends StatelessWidget {
  final InnerConnectionController controller;

  const AttentionAreaPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              100.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.anIdeaToSitWith,
                  style: AppFonts.poppinsRegular(
                    fontSize: 14.sp,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocalizations.of(context)!.attentionQuestion,
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 18.sp,
                    color: const Color(0xFF2D2D2D),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Column(
                  children: controller.attentionAreaOptions.map((option) {
                    return Obx(() {
                      final isSelected = controller.selectedAttentionArea.value == option;
                      return _OptionButton(
                        text: _getTranslatedOption(context, option),
                        isSelected: isSelected,
                        onTap: () async {
                          if (option == 'Other') {
                            final customValue = await showOtherOptionDialog(
                              context: context,
                              title: AppLocalizations.of(context)!.attentionQuestion,
                              initialValue: controller.customAttentionArea.value,
                            );
                            controller.setCustomAttentionArea(customValue);
                          } else {
                            controller.selectAttentionArea(option);
                          }
                        },
                      );
                    });
                  }).toList(),
                ),
                const Spacer(),
                Obx(() => CustomButton(
                  label: AppLocalizations.of(context)!.finishBtn,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.canContinue()
                      ? () => controller.nextPage(
                            onComplete: () => context.go('/home'),
                          )
                      : null,
                  enabled: controller.canContinue(),
                )),
                SizedBox(height: 25.h),
                Text(
                  AppLocalizations.of(context)!.poweredByReflectly,
                  style: AppFonts.poppinsRegular(
                    fontSize: 12.sp,
                    color: const Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== OPTION BUTTON WIDGET ====================
class _OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
          decoration: ShapeDecoration(
            color: isSelected ? const Color(0x66C3A95F) : const Color(0x33C3A99F),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                color: isSelected ? const Color(0xFFC3A95E) : const Color(0x66C3A95E),
              ),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppFonts.poppinsRegular(
              fontSize: 16.sp,
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== PRONOUN BUTTON WIDGET ====================
class _PronounButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _PronounButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0x66C3A95F) : const Color(0x33C3A99F),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.w,
              color: isSelected ? const Color(0xFFC3A95E) : const Color(0x66C3A95E),
            ),
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppFonts.poppinsRegular(
            fontSize: 12.sp,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ),
    );
  }
}
