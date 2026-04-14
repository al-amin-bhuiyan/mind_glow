import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
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

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Dependency.initDeferred();
  }
}

class Dependency {
  /// Initialize only critical controllers needed for app startup
  /// This runs synchronously during app initialization for fast startup


  /// Initialize non-critical controllers after app starts
  /// This runs asynchronously to avoid blocking app startup
  static void initDeferred() {
    // Lazy load CustomNavBarController when needed
    Get.lazyPut<CustomNavBarController>(() => CustomNavBarController(), fenix: true);

    // Lazy load LoginController when needed
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);

    // Lazy load Subscription when needed
    Get.lazyPut<SubscriptionController>(() => SubscriptionController(), fenix: true);

    // Lazy load SignUpController when needed
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);

    // Lazy load ResetPasswordController when needed
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController(), fenix: true);

    // Lazy load OtpScreenController when needed
    Get.lazyPut<OtpScreenController>(() => OtpScreenController(), fenix: true);

    // Lazy load InnerConnectionController when needed
    Get.lazyPut<InnerConnectionController>(() => InnerConnectionController(), fenix: true);

    // Lazy load HomeController when needed
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);

    // Lazy load ReflectController when needed
    Get.lazyPut<ReflectController>(() => ReflectController(), fenix: true);

    // Lazy load JourneyController when needed
    Get.lazyPut<JourneyController>(() => JourneyController(), fenix: true);

    // Lazy load InnerLearningController when needed
    Get.lazyPut<InnerLearningController>(() => InnerLearningController(), fenix: true);

    // Lazy load RelationshipLearningController when needed
    Get.lazyPut<RelationshipLearningController>(() => RelationshipLearningController(), fenix: true);

    // Lazy load ProfileController when needed
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
  }

  /// Legacy method for backward compatibility - deprecated
  @Deprecated('Use initCritical() and initDeferred() instead')
  static void init() {
    initDeferred();
  }
}