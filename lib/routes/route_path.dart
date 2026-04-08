import 'package:mind_glow/routes/app_path.dart';
import 'package:mind_glow/views/onboarding/onboarding.dart';
import 'package:mind_glow/views/profile/profile.dart';
import 'package:mind_glow/views/profile/widgets/edit_profile/edit_profile.dart';
import 'package:mind_glow/views/profile/widgets/notification/notification.dart';
import 'package:mind_glow/views/profile/widgets/security/change_password/change_password.dart';
import 'package:mind_glow/views/profile/widgets/security/security.dart';
import 'package:mind_glow/views/profile/widgets/subscription/subscription.dart';
import 'package:mind_glow/views/profile/widgets/support_and_help/contact_support/contact_support.dart';
import 'package:mind_glow/views/profile/widgets/support_and_help/faqs/faqs.dart';
import 'package:mind_glow/views/profile/widgets/support_and_help/privacy_policy/privacy_policy.dart';
import 'package:mind_glow/views/profile/widgets/support_and_help/support_and_help.dart';
import 'package:mind_glow/views/profile/widgets/support_and_help/terms_and_condition/terms_and_condition.dart';
import 'package:mind_glow/views/reflect/reflect_blob/reflect_blob.dart';
import 'package:mind_glow/views/reflect/reflect_voice/reflect_voice.dart';
import 'package:mind_glow/views/inner_learning/inner_learning.dart';
import 'package:mind_glow/views/inner_learning/relationship_learning/relationship_learning.dart';
import 'package:go_router/go_router.dart';

import '../views/auth_guard/auth_guard_screen.dart';
import '../views/inspire/inspire.dart';
import '../views/reflect/reflect.dart';
import '../views/journey/journey.dart';
import '../views/login/login_screen.dart';
import '../views/sign_up/sign_up.dart';
import '../views/reset_password/reset_password.dart';
import '../views/otp_screen/otp_screen.dart';
import '../views/inner_connection/inner_connection.dart';
import '../views/home/home_screen.dart';
import 'app_path.dart';

class RoutePath {
  static final GoRouter router = GoRouter(
    initialLocation: '/', // Start with the auth guard!
    routes: [
      GoRoute(
        path: '/',
        name: 'authGuard',
        builder: (context, state) => const AuthGuardScreen(),
      ),
      GoRoute(
        path: AppPath.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppPath.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppPath.signup,
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppPath.resetPassword,
        name: 'resetPassword',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AppPath.otpVerification,
        name: 'otpVerification',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] as String?;
          return OtpScreen(email: email);
        },
      ),
      GoRoute(
        path: AppPath.innerConnection,
        name: 'innerConnection',
        builder: (context, state) => const InnerConnectionScreen(),
      ),
      GoRoute(
        path: AppPath.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppPath.reflect,
        name: 'reflect',
        builder: (context, state) => const ReflectScreen(),
      ),
      GoRoute(
        path: AppPath.journey,
        name: 'journey',
        builder: (context, state) => JourneyScreen(),
      ),
      GoRoute(
        path: AppPath.inspire,
        name: 'inspire',
        builder: (context, state) => InspireScreen(),
      ),
      GoRoute(
        path: AppPath.editProfile,
        name: 'editProfile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppPath.profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppPath.subscription,
        name: 'subscription',
        builder: (context, state) => const SubscriptionScreen(),
      ),
      GoRoute(
        path: AppPath.notification,
        name: 'notification',
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: AppPath.security,
        name: 'security',
        builder: (context, state) => const SecurityScreen(),
      ),
      GoRoute(
        path: AppPath.changePassword,
        name: 'changePassword',
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: AppPath.supportAndHelp,
        name: 'supportAndHelp',
        builder: (context, state) => const SupportAndHelpScreen(),
      ),
      GoRoute(
        path: AppPath.faqs,
        name: 'faqs',
        builder: (context, state) => const FaqsScreen(),
      ),
      GoRoute(
        path: AppPath.contactSupport,
        name: 'contactSupport',
        builder: (context, state) => const ContactSupportScreen(),
      ),
      GoRoute(
        path: AppPath.privacyPolicy,
        name: 'privacyPolicy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppPath.termsCondition,
        name: 'termsCondition',
        builder: (context, state) => const TermsConditionScreen(),
      ),
      GoRoute(
        path: AppPath.reflectblob,
        name: 'reflectblob',
        builder: (context, state) => const ReflectBlobScreen(),
      ),
      GoRoute(
        path: AppPath.reflectvoice,
        name: 'reflectvoice',
        builder: (context, state) => const ReflectVoiceScreen(),
      ),
      GoRoute(
        path: AppPath.innerLearning,
        name: 'innerLearning',
        builder: (context, state) => const InnerLearningScreen(),
      ),
      GoRoute(
        path: AppPath.relationshipLearning,
        name: 'relationshipLearning',
        builder: (context, state) => const RelationshipLearningScreen(),
      ),
    ],
  );
}