import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @supportAndHelp.
  ///
  /// In en, this message translates to:
  /// **'Support & Help'**
  String get supportAndHelp;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Hello , {name},'**
  String goodMorning(String name);

  /// No description provided for @quietSpaceAwaits.
  ///
  /// In en, this message translates to:
  /// **'A quiet space for reflection awaits you.'**
  String get quietSpaceAwaits;

  /// No description provided for @whatFeelsPresent.
  ///
  /// In en, this message translates to:
  /// **'What feels present right now?'**
  String get whatFeelsPresent;

  /// No description provided for @startReflections.
  ///
  /// In en, this message translates to:
  /// **'Start Reflections>'**
  String get startReflections;

  /// No description provided for @questionToReflect.
  ///
  /// In en, this message translates to:
  /// **'A question you may wish to reflect on'**
  String get questionToReflect;

  /// No description provided for @reflectionQuestion.
  ///
  /// In en, this message translates to:
  /// **'When was the last time you felt truly confident — and what felt different in that moment?'**
  String get reflectionQuestion;

  /// No description provided for @startSession.
  ///
  /// In en, this message translates to:
  /// **'Start Session>'**
  String get startSession;

  /// No description provided for @journeySoFar.
  ///
  /// In en, this message translates to:
  /// **'Your journey so far'**
  String get journeySoFar;

  /// No description provided for @reflectionsWritten.
  ///
  /// In en, this message translates to:
  /// **'7 reflections\nwritten'**
  String get reflectionsWritten;

  /// No description provided for @themesExplored.
  ///
  /// In en, this message translates to:
  /// **'3 themes\nexplored'**
  String get themesExplored;

  /// No description provided for @reflectedDays.
  ///
  /// In en, this message translates to:
  /// **'Reflected\nover 6 days'**
  String get reflectedDays;

  /// No description provided for @quietInspiration.
  ///
  /// In en, this message translates to:
  /// **'A quiet inspiration'**
  String get quietInspiration;

  /// No description provided for @growthBeginsText.
  ///
  /// In en, this message translates to:
  /// **'Growth begins when we notice what we usually overlook. Shown based on your preferences.'**
  String get growthBeginsText;

  /// No description provided for @journeyTabTitle.
  ///
  /// In en, this message translates to:
  /// **'Journey'**
  String get journeyTabTitle;

  /// No description provided for @journeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'A quiet space holding your reflections, just as you shared them.'**
  String get journeySubtitle;

  /// No description provided for @pastReflections.
  ///
  /// In en, this message translates to:
  /// **'Your past reflections'**
  String get pastReflections;

  /// No description provided for @returnToReflectionNote.
  ///
  /// In en, this message translates to:
  /// **'You can return to any reflection whenever it feels right.'**
  String get returnToReflectionNote;

  /// No description provided for @yourReflectionsSoFar.
  ///
  /// In en, this message translates to:
  /// **'Your reflections so far'**
  String get yourReflectionsSoFar;

  /// No description provided for @reflectionsWrittenStat.
  ///
  /// In en, this message translates to:
  /// **'{count} reflections written'**
  String reflectionsWrittenStat(int count);

  /// No description provided for @themesExploredStat.
  ///
  /// In en, this message translates to:
  /// **'{count} themes explored'**
  String themesExploredStat(int count);

  /// No description provided for @reflectedDaysStat.
  ///
  /// In en, this message translates to:
  /// **'Reflected over {count} days'**
  String reflectedDaysStat(int count);

  /// No description provided for @filterText.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filterText;

  /// No description provided for @filterByTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter by'**
  String get filterByTitle;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterByTheme.
  ///
  /// In en, this message translates to:
  /// **'By Theme'**
  String get filterByTheme;

  /// No description provided for @filterByTime.
  ///
  /// In en, this message translates to:
  /// **'By Time'**
  String get filterByTime;

  /// No description provided for @april12.
  ///
  /// In en, this message translates to:
  /// **'April 12'**
  String get april12;

  /// No description provided for @selfConfident.
  ///
  /// In en, this message translates to:
  /// **'Self-Confident.'**
  String get selfConfident;

  /// No description provided for @relationships.
  ///
  /// In en, this message translates to:
  /// **'Relationships.'**
  String get relationships;

  /// No description provided for @mockDesc1.
  ///
  /// In en, this message translates to:
  /// **'You reflected on moments where speaking up felt uncertain.'**
  String get mockDesc1;

  /// No description provided for @mockDesc2.
  ///
  /// In en, this message translates to:
  /// **'You considered how past experiences have shaped your sense of confidence.'**
  String get mockDesc2;

  /// No description provided for @mockDesc3.
  ///
  /// In en, this message translates to:
  /// **'You shared that sometimes you feel a weight in your sense of confidence.'**
  String get mockDesc3;

  /// No description provided for @mockDesc4.
  ///
  /// In en, this message translates to:
  /// **'You reflected on how feeling supported deepens your connections.'**
  String get mockDesc4;

  /// No description provided for @reflectTitle.
  ///
  /// In en, this message translates to:
  /// **'Reflect'**
  String get reflectTitle;

  /// No description provided for @reflectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A quiet space to explore your thoughts.'**
  String get reflectSubtitle;

  /// No description provided for @reflectInputHint.
  ///
  /// In en, this message translates to:
  /// **'I like working on the'**
  String get reflectInputHint;

  /// No description provided for @inspireTitle.
  ///
  /// In en, this message translates to:
  /// **'Inspire'**
  String get inspireTitle;

  /// No description provided for @inspireSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Quiet words and ideas to sit with.'**
  String get inspireSubtitle;

  /// No description provided for @whatYouReflectedOn.
  ///
  /// In en, this message translates to:
  /// **'What you\'ve reflected on'**
  String get whatYouReflectedOn;

  /// No description provided for @chooseWhatFeelsMeaningful.
  ///
  /// In en, this message translates to:
  /// **'Choose what feels meaningful to you .'**
  String get chooseWhatFeelsMeaningful;

  /// No description provided for @saveInspirations.
  ///
  /// In en, this message translates to:
  /// **'Save Inspirations'**
  String get saveInspirations;

  /// No description provided for @wordsYouChoseToKeep.
  ///
  /// In en, this message translates to:
  /// **'Words you chose to keep'**
  String get wordsYouChoseToKeep;

  /// No description provided for @inspirationVideo.
  ///
  /// In en, this message translates to:
  /// **'Inspiration Video'**
  String get inspirationVideo;

  /// No description provided for @inspireBottomNote.
  ///
  /// In en, this message translates to:
  /// **'You may return to reflection whenever it feels right'**
  String get inspireBottomNote;

  /// No description provided for @categoryVoices.
  ///
  /// In en, this message translates to:
  /// **'Voices'**
  String get categoryVoices;

  /// No description provided for @categoryMeaning.
  ///
  /// In en, this message translates to:
  /// **'Meaning'**
  String get categoryMeaning;

  /// No description provided for @categoryPerspectives.
  ///
  /// In en, this message translates to:
  /// **'Perspectives'**
  String get categoryPerspectives;

  /// No description provided for @categoryWhatMatters.
  ///
  /// In en, this message translates to:
  /// **'What Matters'**
  String get categoryWhatMatters;

  /// No description provided for @featuredQuoteText.
  ///
  /// In en, this message translates to:
  /// **'\"Not everything that feels unresolved need immediate clarity.\"'**
  String get featuredQuoteText;

  /// No description provided for @featuredQuoteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Chosen based on what resonates with you'**
  String get featuredQuoteSubtitle;

  /// No description provided for @typeQuote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get typeQuote;

  /// No description provided for @typeRoleModels.
  ///
  /// In en, this message translates to:
  /// **'Role Models'**
  String get typeRoleModels;

  /// No description provided for @mockInspireTitle.
  ///
  /// In en, this message translates to:
  /// **'Sometimes clarity arrives\nwhen we stop pushing \nfor it.'**
  String get mockInspireTitle;

  /// No description provided for @mockContextPatience.
  ///
  /// In en, this message translates to:
  /// **'Save during a reflection on patience'**
  String get mockContextPatience;

  /// No description provided for @mockContextQuiet.
  ///
  /// In en, this message translates to:
  /// **'Save after a quite moments'**
  String get mockContextQuiet;

  /// No description provided for @mockContextAcceptance.
  ///
  /// In en, this message translates to:
  /// **'Save during a reflection on acceptance'**
  String get mockContextAcceptance;

  /// No description provided for @whatToLearnToday.
  ///
  /// In en, this message translates to:
  /// **'What do you want to learn today?'**
  String get whatToLearnToday;

  /// No description provided for @innerLearningTitle.
  ///
  /// In en, this message translates to:
  /// **'Inner Learning'**
  String get innerLearningTitle;

  /// No description provided for @yourPastLearnings.
  ///
  /// In en, this message translates to:
  /// **'Your past Learnings'**
  String get yourPastLearnings;

  /// No description provided for @seeLess.
  ///
  /// In en, this message translates to:
  /// **'See Less'**
  String get seeLess;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get seeMore;

  /// No description provided for @suggestionRelationship.
  ///
  /// In en, this message translates to:
  /// **'I want to learn about relationship.'**
  String get suggestionRelationship;

  /// No description provided for @suggestionSelfReflection.
  ///
  /// In en, this message translates to:
  /// **'I want to learn about self reflection.'**
  String get suggestionSelfReflection;

  /// No description provided for @suggestionSelfConfident.
  ///
  /// In en, this message translates to:
  /// **'I want to learn about self confident.'**
  String get suggestionSelfConfident;

  /// No description provided for @inputHintRelationship.
  ///
  /// In en, this message translates to:
  /// **'I want to learn about relationship'**
  String get inputHintRelationship;

  /// No description provided for @relationshipLearningTitle.
  ///
  /// In en, this message translates to:
  /// **'Relationship Learning'**
  String get relationshipLearningTitle;

  /// No description provided for @learnAboutRelationships.
  ///
  /// In en, this message translates to:
  /// **'Learn About Relationships'**
  String get learnAboutRelationships;

  /// No description provided for @buildHealthyConnections.
  ///
  /// In en, this message translates to:
  /// **'Build healthy, meaningful, and lasting connections with others.'**
  String get buildHealthyConnections;

  /// No description provided for @relationshipLearningContent.
  ///
  /// In en, this message translates to:
  /// **'Healthy relationships are built on trust, respect, understanding, and emotional safety. A strong connection does not mean there will be no disagreements — it means both people are willing to communicate openly and solve problems together.\n\nGood communication is the foundation of every meaningful relationship. It involves listening without judgment, expressing feelings honestly, and respecting each other\'s perspective. When both individuals feel heard and valued, the bond becomes stronger.\n\nSetting healthy boundaries is also important. Boundaries are not walls; they are guidelines that protect emotional well-being. They help both people understand what is acceptable and what is not.\n\nIn any relationship, conflicts are normal. What truly matters is how those conflicts are handled. Responding with patience, empathy, and maturity helps maintain trust and emotional stability.\n\nA healthy relationship should make you feel supported, respected, and safe — not anxious or uncertain. Take time to reflect on the kind of connection you want in your life and whether your current relationships align with your values and emotional needs.'**
  String get relationshipLearningContent;

  /// No description provided for @april11.
  ///
  /// In en, this message translates to:
  /// **'April 11'**
  String get april11;

  /// No description provided for @april10.
  ///
  /// In en, this message translates to:
  /// **'April 10'**
  String get april10;

  /// No description provided for @learnAboutSelfReflection.
  ///
  /// In en, this message translates to:
  /// **'Learn About Self Reflection.'**
  String get learnAboutSelfReflection;

  /// No description provided for @learnAboutSelfConfident.
  ///
  /// In en, this message translates to:
  /// **'Learn About Self Confident.'**
  String get learnAboutSelfConfident;

  /// No description provided for @learnAboutPatience.
  ///
  /// In en, this message translates to:
  /// **'Learn About Patience'**
  String get learnAboutPatience;

  /// No description provided for @learnAboutGrowth.
  ///
  /// In en, this message translates to:
  /// **'Learn About Growth'**
  String get learnAboutGrowth;

  /// No description provided for @mockDescPatience.
  ///
  /// In en, this message translates to:
  /// **'You explored how waiting can sometimes feel uncomfortable.'**
  String get mockDescPatience;

  /// No description provided for @mockDescGrowth.
  ///
  /// In en, this message translates to:
  /// **'You discovered how small steps lead to meaningful changes.'**
  String get mockDescGrowth;

  /// No description provided for @aMomentToNotice.
  ///
  /// In en, this message translates to:
  /// **'A moment to notice'**
  String get aMomentToNotice;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// No description provided for @yourNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get yourNameHint;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue >'**
  String get continueBtn;

  /// No description provided for @poweredByReflectly.
  ///
  /// In en, this message translates to:
  /// **'Powered by The Reflectly Method.'**
  String get poweredByReflectly;

  /// No description provided for @ageRangeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which age range feels closest to you?'**
  String get ageRangeQuestion;

  /// No description provided for @lifeSituationQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which best describes your current life situation?'**
  String get lifeSituationQuestion;

  /// No description provided for @lifeStageQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which best describes where you are in life right now?'**
  String get lifeStageQuestion;

  /// No description provided for @aSpaceToExplore.
  ///
  /// In en, this message translates to:
  /// **'A space to explore'**
  String get aSpaceToExplore;

  /// No description provided for @lifeFeelingQuestion.
  ///
  /// In en, this message translates to:
  /// **'Overall, your life feels mostly...'**
  String get lifeFeelingQuestion;

  /// No description provided for @anIdeaToSitWith.
  ///
  /// In en, this message translates to:
  /// **'An idea to sit with'**
  String get anIdeaToSitWith;

  /// No description provided for @faithQuestion.
  ///
  /// In en, this message translates to:
  /// **'Does faith, spirituality, or belief play a role in your life?'**
  String get faithQuestion;

  /// No description provided for @inspirationQuestion.
  ///
  /// In en, this message translates to:
  /// **'What voices or sources feel most inspiring or grounding to you?'**
  String get inspirationQuestion;

  /// No description provided for @attentionQuestion.
  ///
  /// In en, this message translates to:
  /// **'What would you like to give attention to today?'**
  String get attentionQuestion;

  /// No description provided for @finishBtn.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishBtn;

  /// No description provided for @preferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get preferNotToSay;

  /// No description provided for @cancelBtn.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelBtn;

  /// No description provided for @okBtn.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okBtn;

  /// No description provided for @pleaseSpecifyHint.
  ///
  /// In en, this message translates to:
  /// **'Please specify...'**
  String get pleaseSpecifyHint;

  /// No description provided for @optSheHer.
  ///
  /// In en, this message translates to:
  /// **'She/Her'**
  String get optSheHer;

  /// No description provided for @optHeHim.
  ///
  /// In en, this message translates to:
  /// **'He/Him'**
  String get optHeHim;

  /// No description provided for @optNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Not to say'**
  String get optNotToSay;

  /// No description provided for @optUnder18.
  ///
  /// In en, this message translates to:
  /// **'Under 18 years'**
  String get optUnder18;

  /// No description provided for @opt18_24.
  ///
  /// In en, this message translates to:
  /// **'18-24'**
  String get opt18_24;

  /// No description provided for @opt25_34.
  ///
  /// In en, this message translates to:
  /// **'25-34'**
  String get opt25_34;

  /// No description provided for @opt35_44.
  ///
  /// In en, this message translates to:
  /// **'35-44'**
  String get opt35_44;

  /// No description provided for @opt45_64.
  ///
  /// In en, this message translates to:
  /// **'45-64'**
  String get opt45_64;

  /// No description provided for @opt65Plus.
  ///
  /// In en, this message translates to:
  /// **'65+'**
  String get opt65Plus;

  /// No description provided for @optSingle.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get optSingle;

  /// No description provided for @optMarried.
  ///
  /// In en, this message translates to:
  /// **'Married'**
  String get optMarried;

  /// No description provided for @optInRelationship.
  ///
  /// In en, this message translates to:
  /// **'In a Relationship'**
  String get optInRelationship;

  /// No description provided for @optSeparatedDivorced.
  ///
  /// In en, this message translates to:
  /// **'Separated / Divorced'**
  String get optSeparatedDivorced;

  /// No description provided for @optWidowed.
  ///
  /// In en, this message translates to:
  /// **'Widowed'**
  String get optWidowed;

  /// No description provided for @optStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get optStudent;

  /// No description provided for @optWorkingProfessional.
  ///
  /// In en, this message translates to:
  /// **'Working professional'**
  String get optWorkingProfessional;

  /// No description provided for @optParentCaregiver.
  ///
  /// In en, this message translates to:
  /// **'Parent / caregiver'**
  String get optParentCaregiver;

  /// No description provided for @optSelfEmployed.
  ///
  /// In en, this message translates to:
  /// **'Self-employed / Building something'**
  String get optSelfEmployed;

  /// No description provided for @optRetired.
  ///
  /// In en, this message translates to:
  /// **'Retired'**
  String get optRetired;

  /// No description provided for @optBusyOverwhelming.
  ///
  /// In en, this message translates to:
  /// **'Busy / overwhelming'**
  String get optBusyOverwhelming;

  /// No description provided for @optStableHeavy.
  ///
  /// In en, this message translates to:
  /// **'Stable but heavy'**
  String get optStableHeavy;

  /// No description provided for @optBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get optBalanced;

  /// No description provided for @optUncertain.
  ///
  /// In en, this message translates to:
  /// **'Uncertain'**
  String get optUncertain;

  /// No description provided for @optMindfulness.
  ///
  /// In en, this message translates to:
  /// **'Mindfulness'**
  String get optMindfulness;

  /// No description provided for @optQuietDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Quiet but disconnected'**
  String get optQuietDisconnected;

  /// No description provided for @optChristianity.
  ///
  /// In en, this message translates to:
  /// **'Christianity'**
  String get optChristianity;

  /// No description provided for @optIslam.
  ///
  /// In en, this message translates to:
  /// **'Islam'**
  String get optIslam;

  /// No description provided for @optJudaism.
  ///
  /// In en, this message translates to:
  /// **'Judaism'**
  String get optJudaism;

  /// No description provided for @optBuddhism.
  ///
  /// In en, this message translates to:
  /// **'Buddhism'**
  String get optBuddhism;

  /// No description provided for @optHinduism.
  ///
  /// In en, this message translates to:
  /// **'Hinduism'**
  String get optHinduism;

  /// No description provided for @optAnotherFaith.
  ///
  /// In en, this message translates to:
  /// **'Another faith or spiritual path'**
  String get optAnotherFaith;

  /// No description provided for @optNonReligious.
  ///
  /// In en, this message translates to:
  /// **'I prefer non-religious inspiration'**
  String get optNonReligious;

  /// No description provided for @optSacredTexts.
  ///
  /// In en, this message translates to:
  /// **'Sacred or spiritual texts'**
  String get optSacredTexts;

  /// No description provided for @optSpiritualTeachers.
  ///
  /// In en, this message translates to:
  /// **'Spiritual teachers or scholars'**
  String get optSpiritualTeachers;

  /// No description provided for @optPublicFigures.
  ///
  /// In en, this message translates to:
  /// **'Public figures or role models'**
  String get optPublicFigures;

  /// No description provided for @optWritersBooks.
  ///
  /// In en, this message translates to:
  /// **'Writers or books'**
  String get optWritersBooks;

  /// No description provided for @optArtistsCreators.
  ///
  /// In en, this message translates to:
  /// **'Artists, creators, or influencers'**
  String get optArtistsCreators;

  /// No description provided for @optNameSpecific.
  ///
  /// In en, this message translates to:
  /// **'Name specific people, books, or voices'**
  String get optNameSpecific;

  /// No description provided for @optSomethingCarrying.
  ///
  /// In en, this message translates to:
  /// **'Something I\'ve been carrying'**
  String get optSomethingCarrying;

  /// No description provided for @optFeelingNotUnderstand.
  ///
  /// In en, this message translates to:
  /// **'A feeling I don\'t fully understand'**
  String get optFeelingNotUnderstand;

  /// No description provided for @optSituationInLife.
  ///
  /// In en, this message translates to:
  /// **'A situation in my life'**
  String get optSituationInLife;

  /// No description provided for @optPatternNoticed.
  ///
  /// In en, this message translates to:
  /// **'A pattern I\'ve noticed'**
  String get optPatternNoticed;

  /// No description provided for @optDontKnowWantSpace.
  ///
  /// In en, this message translates to:
  /// **'I don\'t know yet — I just want space'**
  String get optDontKnowWantSpace;

  /// No description provided for @optOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get optOther;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
