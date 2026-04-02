import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controllers/journey_controller/journey_controller.dart';
import '../controllers/login_controller/login_controller.dart';
import '../controllers/sign_up_controller/sign_up_controller.dart';
import '../controllers/reset_password_controller/reset_password_controller.dart';
import '../controllers/otp_screen_controller/otp_screen_controller.dart';
import '../controllers/inner_connection_controller/inner_connection_controller.dart';
import '../controllers/home_controller/home_controller.dart';
import '../controllers/reflect_controller/reflect_controller.dart';
import '../controllers/profile_controller/profile_controller.dart';
import '../controllers/inner_learning_controller/inner_learning_controller.dart';
import '../views/inner_learning/relationship_learning/relationship_learning_controller.dart';
import '../views/profile/widgets/subscription/subscription_controller.dart';
import '../controllers/custom_nav_bar_widgets/custom_nav_bar_widgets.dart';

class Dependency {
  /// Initialize only critical controllers needed for app startup
  /// This runs synchronously during app initialization for fast startup


  /// Initialize non-critical controllers after app starts
  /// This runs asynchronously to avoid blocking app startup
  static void initDeferred() {
    // Lazy load CustomNavBarController when needed
    Get.lazyPut<CustomNavBarController>(() => CustomNavBarController(), fenix: true);

    // Lazy load LoginController when needed
    Get.lazyPut<LoginController>(() => LoginController());

    // Lazy load Subscription when needed
    Get.lazyPut<SubscriptionController>(() => SubscriptionController());

    // Lazy load SignUpController when needed
    Get.lazyPut<SignUpController>(() => SignUpController());

    // Lazy load ResetPasswordController when needed
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());

    // Lazy load OtpScreenController when needed
    Get.lazyPut<OtpScreenController>(() => OtpScreenController());

    // Lazy load InnerConnectionController when needed
    Get.lazyPut<InnerConnectionController>(() => InnerConnectionController());

    // Lazy load HomeController when needed
    Get.lazyPut<HomeController>(() => HomeController());

    // Lazy load ReflectController when needed
    Get.lazyPut<ReflectController>(() => ReflectController());

    // Lazy load JourneyController when needed
    Get.lazyPut<JourneyController>(() => JourneyController());

    // Lazy load InnerLearningController when needed
    Get.lazyPut<InnerLearningController>(() => InnerLearningController());

    // Lazy load RelationshipLearningController when needed
    Get.lazyPut<RelationshipLearningController>(() => RelationshipLearningController());

    // Lazy load ProfileController when needed
    Get.lazyPut<ProfileController>(() => ProfileController());
  }

  /// Legacy method for backward compatibility - deprecated
  @Deprecated('Use initCritical() and initDeferred() instead')
  static void init() {
    initDeferred();
  }
}
