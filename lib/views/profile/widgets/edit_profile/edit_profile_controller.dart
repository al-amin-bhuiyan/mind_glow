import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../utils/toast_message.dart';
import '../../../../utils/app_colors.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/token_storage_service.dart';

/// Controller for Edit Profile Screen - handles profile editing logic
class EditProfileController extends GetxController {
  // Text editing controllers
  final TextEditingController fullNameController = TextEditingController();

  // Observable selections for popup menus
  final RxString selectedPronoun = ''.obs;
  final RxString selectedAgeRange = ''.obs;
  final RxString selectedLifeSituation = ''.obs;
  final RxString selectedLifeStage = ''.obs;
  final RxString selectedLifeFeeling = ''.obs;
  final RxString selectedFaith = ''.obs;
  final RxString selectedInspirationSource = ''.obs;
  final RxString selectedAttentionArea = ''.obs;

  // Options
  final List<String> pronounOptions = [
    'She/Her',
    'He/Him',
    'Not to say',
  ];

  final List<String> ageRangeOptions = [
    'Under 18 years',
    '18-24',
    '25-34',
    '35-44',
    '45-64',
    '65+',
  ];

  final List<String> lifeSituationOptions = [
    'Single',
    'Married',
    'In a Relationship',
    'Separated / Divorced',
    'Widowed',
    'Other',
  ];

  final List<String> lifeStageOptions = [
    'Student',
    'Working professional',
    'Parent / caregiver',
    'Self-employed / Building something',
    'Retired',
    'Other',
  ];

  final List<String> lifeFeelingOptions = [
    'Busy / overwhelming',
    'Stable but heavy',
    'Balanced',
    'Uncertain',
    'Mindfulness',
    'Quiet but disconnected',
    'Other',
  ];

  final List<String> faithOptions = [
    'Christianity',
    'Islam',
    'Judaism',
    'Buddhism',
    'Hinduism',
    'Another faith or spiritual path',
    'I prefer non-religious inspiration',
    'Other',
  ];

  final List<String> inspirationSourceOptions = [
    'Sacred or spiritual texts',
    'Spiritual teachers or scholars',
    'Public figures or role models',
    'Writers or books',
    'Artists, creators, or influencers',
    'Name specific people, books, or voices',
  ];

  final List<String> attentionAreaOptions = [
    'Something I\'ve been carrying',
    'A feeling I don\'t fully understand',
    'A situation in my life',
    'A pattern I\'ve noticed',
    'I don\'t know yet — I just want space',
    'Other',
  ];

  // Observable states
  final RxBool isLoading = false.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString profileImagePath = ''.obs;

  final AuthService _authService = AuthService.instance;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // Receive data from profile screen via GoRouter extra
  Map<String, dynamic>? routeData;
  String? initialFullName;
  String? initialImagePath;

  /// Initialize with route data
  void initializeWithData(Map<String, dynamic>? data) {
    if (data != null) {
      routeData = data;
      initialFullName = data['full_name'];
      initialImagePath = data['profile_picture'];

      // Set initial values
      fullNameController.text = initialFullName ?? '';
      profileImagePath.value = initialImagePath ?? '';
      
      // Attempt to load from additional data if available inside routeData
      selectedPronoun.value = data['pronouns'] ?? '';
      selectedAgeRange.value = data['age_group'] ?? '';
      selectedLifeSituation.value = data['life_situation'] ?? '';
      selectedLifeStage.value = data['occupation'] ?? '';
      selectedLifeFeeling.value = data['life_feelings'] ?? '';
      selectedFaith.value = data['faith'] ?? '';
      selectedInspirationSource.value = data['inspiration_sources'] ?? '';
      selectedAttentionArea.value = data['attention_today'] ?? '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch profile data from API
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      final token = await TokenStorageService.instance.getAccessToken();
      final response = await _authService.getUserProfile(token: token);

      if (response.success && response.data != null) {
        final data = response.data!;
        
        fullNameController.text = data.fullName ?? '';
        profileImagePath.value = data.profilePicture ?? '';
        
        selectedPronoun.value = data.pronouns ?? '';
        selectedAgeRange.value = data.ageGroup ?? '';
        selectedLifeSituation.value = data.lifeSituation ?? '';
        selectedLifeStage.value = data.occupation ?? '';
        selectedLifeFeeling.value = data.lifeFeelings ?? '';
        selectedFaith.value = data.faith ?? '';
        selectedInspirationSource.value = data.inspirationSources ?? '';
        selectedAttentionArea.value = data.attentionToday ?? '';
      }
    } catch (e) {
      debugPrint('Error fetching profile data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    super.onClose();
  }

  /// Pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
        profileImagePath.value = image.path;
      }
    } catch (e) {
      print('Error picking image: $e');
      ToastMessage.showError('Failed to pick image');
    }
  }

  /// Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
        profileImagePath.value = image.path;
      }
    } catch (e) {
      print('Error taking photo: $e');
      ToastMessage.showError('Failed to take photo');
    }
  }

  /// Show image picker options
  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library, color: const Color(0xFFC39D4C)),
                  title: Text('Choose from Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt, color: const Color(0xFFC39D4C)),
                  title: Text('Take a Photo'),
                  onTap: () {
                    Navigator.pop(context);
                    pickImageFromCamera();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.cancel, color: Colors.grey),
                  title: Text('Cancel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Validate form fields
  bool validateForm() {
    if (fullNameController.text.trim().isEmpty) {
      ToastMessage.showError('Full name is required');
      return false;
    }

    return true;
  }

  /// Save profile changes
  Future<void> saveProfile(BuildContext context) async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;
      final token = await TokenStorageService.instance.getAccessToken();

      final data = <String, String>{
        'full_name': fullNameController.text.trim(),
        'pronouns': selectedPronoun.value,
        'age_group': selectedAgeRange.value,
        'life_situation': selectedLifeSituation.value,
        'occupation': selectedLifeStage.value,
        'life_feelings': selectedLifeFeeling.value,
        'faith': selectedFaith.value,
        'inspiration_sources': selectedInspirationSource.value,
        'attention_today': selectedAttentionArea.value,
      };

      final response = await _authService.updateUserProfile(
        data: data,
        profilePicture: selectedImage.value, // It's only non-null if user picked a new file
        token: token,
      );

      if (response.success && response.data != null) {
        ToastMessage.showSuccess('Profile updated successfully');
        
        // Go back to profile screen
        context.pop();
        Get.delete<EditProfileController>();
      } else {
        ToastMessage.showError(response.errorMessage ?? 'Failed to update profile');
      }
    } catch (e) {
      print('Error saving profile: $e');
      ToastMessage.showError('Failed to save profile');
    } finally {
      isLoading.value = false;
    }
  }

  /// Handle back button press
  void goBack(BuildContext context) {
    context.pop();
    // Delete controller so it gets re-initialized fresh next time
    Get.delete<EditProfileController>();
  }

  void showSelectionBottomSheet(BuildContext context, String title, List<String> options, RxString selectedValue) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    return Obx(() {
                      final isSelected = selectedValue.value == option;
                      return ListTile(
                        title: Text(
                          option,
                          style: TextStyle(
                            color: isSelected ? AppColors.googlebuttonColor : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected 
                            ? Icon(Icons.check, color: AppColors.googlebuttonColor) 
                            : null,
                        onTap: () {
                          selectedValue.value = option;
                          Navigator.pop(context);
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}