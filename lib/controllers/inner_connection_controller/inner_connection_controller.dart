import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../services/auth_service.dart';
import '../../services/token_storage_service.dart';
import '../../models/complete_profile_model.dart';

/// Inner Connection Controller - Manages inner connection questionnaire flow
class InnerConnectionController extends GetxController {
  // Current page index (0-7 for 8 pages)
  final RxInt currentPage = 0.obs;
  final int totalPages = 8;
  final RxBool isLoading = false.obs;

  // Dependencies
  final AuthService _authService = AuthService.instance;
  final TokenStorageService _tokenStorage = TokenStorageService.instance;

  // Text editing controller for full name
  final TextEditingController fullNameController = TextEditingController();

  // Custom text for "Other" options
  final RxString customLifeSituation = ''.obs;
  final RxString customLifeStage = ''.obs;
  final RxString customLifeFeeling = ''.obs;
  final RxString customFaith = ''.obs;
  final RxString customAttentionArea = ''.obs;

  // User responses
  final RxString selectedFullName = ''.obs;
  final RxString selectedPronoun = ''.obs;
  final RxString selectedAgeRange = ''.obs;
  final RxString selectedLifeSituation = ''.obs;
  final RxString selectedLifeStage = ''.obs;
  final RxString selectedLifeFeeling = ''.obs;
  final RxString selectedFaith = ''.obs;
  final RxString selectedInspirationSource = ''.obs;
  final RxString selectedAttentionArea = ''.obs;

  // Pronoun options (Page 0 - 1/8)
  final List<String> pronounOptions = [
    'She/Her',
    'He/Him',
    'Not to say',
  ];

  // Age range options (Page 1 - 2/8)
  final List<String> ageRangeOptions = [
    'Under 18 years',
    '18-24',
    '25-34',
    '35-44',
    '45-64',
    '65+',
  ];

  // Life situation options (Page 2 - 3/8)
  final List<String> lifeSituationOptions = [
    'Single',
    'Married',
    'In a Relationship',
    'Separated / Divorced',
    'Widowed',
    'Other',
  ];

  // Life stage options (Page 2 - 4/8)
  final List<String> lifeStageOptions = [
    'Student',
    'Working professional',
    'Parent / caregiver',
    'Self-employed / Building something',
    'Retired',
    'Other',
  ];

  // Life feeling options (Page 3 - 5/8)
  final List<String> lifeFeelingOptions = [
    'Busy / overwhelming',
    'Stable but heavy',
    'Balanced',
    'Uncertain',
    'Mindfulness',
    'Quiet but disconnected',
    'Other',
  ];

  // Faith options (Page 4 - 6/8)
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

  // Inspiration source options (Page 5 - 7/8)
  final List<String> inspirationSourceOptions = [
    'Sacred or spiritual texts',
    'Spiritual teachers or scholars',
    'Public figures or role models',
    'Writers or books',
    'Artists, creators, or influencers',
    'Name specific people, books, or voices',
  ];

  // Attention area options (Page 6 - 8/8)
  final List<String> attentionAreaOptions = [
    'Something I\'ve been carrying',
    'A feeling I don\'t fully understand',
    'A situation in my life',
    'A pattern I\'ve noticed',
    'I don\'t know yet — I just want space',
    'Other',
  ];

  /// Navigation methods
  void nextPage({VoidCallback? onComplete}) {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    } else {
      completeQuestionnaire(onComplete: onComplete);
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  /// Selection methods
  void updateFullName(String name) {
    selectedFullName.value = name;
  }

  void selectPronoun(String pronoun) {
    selectedPronoun.value = pronoun;
  }

  void selectAgeRange(String ageRange) {
    selectedAgeRange.value = ageRange;
  }

  void selectLifeSituation(String option) {
    selectedLifeSituation.value = option;
    if (option != 'Other') {
      customLifeSituation.value = '';
    }
  }

  void selectLifeStage(String option) {
    selectedLifeStage.value = option;
    if (option != 'Other') {
      customLifeStage.value = '';
    }
  }

  void selectLifeFeeling(String option) {
    selectedLifeFeeling.value = option;
    if (option != 'Other') {
      customLifeFeeling.value = '';
    }
  }

  void selectFaith(String option) {
    selectedFaith.value = option;
    if (option != 'Other') {
      customFaith.value = '';
    }
  }

  /// Set custom text for "Other" options
  void setCustomLifeSituation(String? value) {
    if (value != null && value.isNotEmpty) {
      customLifeSituation.value = value;
      selectedLifeSituation.value = 'Other';
    } else {
      customLifeSituation.value = '';
      selectedLifeSituation.value = '';
    }
  }

  void setCustomLifeStage(String? value) {
    if (value != null && value.isNotEmpty) {
      customLifeStage.value = value;
      selectedLifeStage.value = 'Other';
    } else {
      customLifeStage.value = '';
      selectedLifeStage.value = '';
    }
  }

  void setCustomLifeFeeling(String? value) {
    if (value != null && value.isNotEmpty) {
      customLifeFeeling.value = value;
      selectedLifeFeeling.value = 'Other';
    } else {
      customLifeFeeling.value = '';
      selectedLifeFeeling.value = '';
    }
  }

  void setCustomFaith(String? value) {
    if (value != null && value.isNotEmpty) {
      customFaith.value = value;
      selectedFaith.value = 'Other';
    } else {
      customFaith.value = '';
      selectedFaith.value = '';
    }
  }

  void selectInspirationSource(String option) {
    selectedInspirationSource.value = option;
  }

  void selectAttentionArea(String option) {
    selectedAttentionArea.value = option;
    if (option != 'Other') {
      customAttentionArea.value = '';
    }
  }

  /// Set custom attention area for "Other" option
  void setCustomAttentionArea(String? value) {
    if (value != null && value.isNotEmpty) {
      customAttentionArea.value = value;
      selectedAttentionArea.value = 'Other';
    } else {
      customAttentionArea.value = '';
      selectedAttentionArea.value = '';
    }
  }

  /// Check if user can continue from current page
  bool canContinue() {
    switch (currentPage.value) {
      case 0:
        return selectedFullName.value.trim().isNotEmpty && selectedPronoun.value.isNotEmpty;
      case 1:
        return selectedAgeRange.value.isNotEmpty;
      case 2:
        return selectedLifeSituation.value.isNotEmpty;
      case 3:
        return selectedLifeStage.value.isNotEmpty;
      case 4:
        return selectedLifeFeeling.value.isNotEmpty;
      case 5:
        return selectedFaith.value.isNotEmpty;
      case 6:
        return selectedInspirationSource.value.isNotEmpty;
      case 7:
        return selectedAttentionArea.value.isNotEmpty;
      default:
        return false;
    }
  }

  /// Get progress for progress bar (pages 0-7 show progress)
  double getProgress() {
    const progressBarPages = 8;
    return (currentPage.value + 1) / progressBarPages;
  }

  /// Get all user data
  Map<String, String> getUserData() {
    return {
      'fullName': selectedFullName.value,
      'pronoun': selectedPronoun.value,
      'ageRange': selectedAgeRange.value,
      'lifeSituation': selectedLifeSituation.value == 'Other'
          ? customLifeSituation.value
          : selectedLifeSituation.value,
      'lifeStage': selectedLifeStage.value == 'Other'
          ? customLifeStage.value
          : selectedLifeStage.value,
      'lifeFeeling': selectedLifeFeeling.value == 'Other'
          ? customLifeFeeling.value
          : selectedLifeFeeling.value,
      'faith': selectedFaith.value == 'Other'
          ? customFaith.value
          : selectedFaith.value,
      'inspirationSource': selectedInspirationSource.value,
      'attentionArea': selectedAttentionArea.value == 'Other'
          ? customAttentionArea.value
          : selectedAttentionArea.value,
    };
  }

  /// Complete questionnaire
  Future<void> completeQuestionnaire({VoidCallback? onComplete}) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      debugPrint('====== Inner Connection Completed! ======');
      
      final String lifeSituation = selectedLifeSituation.value == 'Other' 
          ? customLifeSituation.value 
          : selectedLifeSituation.value;
          
      final String occupation = selectedLifeStage.value == 'Other' 
          ? customLifeStage.value 
          : selectedLifeStage.value;
          
      final String lifeFeelings = selectedLifeFeeling.value == 'Other' 
          ? customLifeFeeling.value 
          : selectedLifeFeeling.value;
          
      final String faith = selectedFaith.value == 'Other' 
          ? customFaith.value 
          : selectedFaith.value;
          
      final String attentionToday = selectedAttentionArea.value == 'Other' 
          ? customAttentionArea.value 
          : selectedAttentionArea.value;

      final request = CompleteProfileRequestModel(
        fullName: selectedFullName.value,
        ageGroup: selectedAgeRange.value,
        lifeSituation: lifeSituation,
        occupation: occupation,
        lifeFeelings: lifeFeelings,
        faith: faith,
        inspirationSources: selectedInspirationSource.value,
        attentionToday: attentionToday,
      );

      final token = await _tokenStorage.getAccessToken();

      final response = await _authService.completeProfile(
        request: request,
        token: token,
      );

      if (response.success) {
        Fluttertoast.showToast(msg: response.data?.message ?? 'Profile saved successfully!', gravity: ToastGravity.TOP, backgroundColor: Colors.green, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT);
        
        Future.delayed(const Duration(milliseconds: 500), () {
          if (onComplete != null) {
            onComplete();
          }
        });
      } else {
        Fluttertoast.showToast(msg: response.errorMessage ?? 'Failed to save profile.', gravity: ToastGravity.TOP, backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT);
      }
    } catch (e) {
      debugPrint('❌ Profile complete error: $e');
      Fluttertoast.showToast(msg: 'An error occurred while saving profile.', gravity: ToastGravity.TOP, backgroundColor: Colors.red, textColor: Colors.white, toastLength: Toast.LENGTH_SHORT);
    } finally {
      isLoading.value = false;
    }
  }

  /// Reset all selections
  void resetQuestionnaire() {
    currentPage.value = 0;
    fullNameController.clear();
    selectedFullName.value = '';
    selectedPronoun.value = '';
    selectedAgeRange.value = '';
    selectedLifeSituation.value = '';
    selectedLifeStage.value = '';
    selectedLifeFeeling.value = '';
    selectedFaith.value = '';
    selectedInspirationSource.value = '';
    selectedAttentionArea.value = '';
    customLifeSituation.value = '';
    customLifeStage.value = '';
    customLifeFeeling.value = '';
    customFaith.value = '';
    customAttentionArea.value = '';
  }

  @override
  void onClose() {
    fullNameController.dispose();
    super.onClose();
  }
}