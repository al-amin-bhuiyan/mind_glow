import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../utils/toast_message.dart';

/// Controller for Edit Profile Screen - handles profile editing logic
class EditProfileController extends GetxController {
  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  // Observable states
  final RxBool isLoading = false.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString profileImagePath = ''.obs;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // Receive data from profile screen via GoRouter extra
  Map<String, dynamic>? routeData;
  String? initialEmail;
  String? initialFirstName;
  String? initialLastName;
  String? initialImagePath;

  /// Initialize with route data
  void initializeWithData(Map<String, dynamic>? data) {
    if (data != null) {
      routeData = data;
      initialEmail = data['email'];
      initialFirstName = data['firstName'];
      initialLastName = data['lastName'];
      initialImagePath = data['imagePath'];

      // Set initial values
      emailController.text = initialEmail ?? '';
      firstNameController.text = initialFirstName ?? '';
      lastNameController.text = initialLastName ?? '';
      profileImagePath.value = initialImagePath ?? '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Data will be initialized via initializeWithData method
    // when screen is built with GoRouter extra parameter
  }

  @override
  void onClose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
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
    if (emailController.text.trim().isEmpty) {
      ToastMessage.showError('Email is required');
      return false;
    }

    if (firstNameController.text.trim().isEmpty) {
      ToastMessage.showError('First name is required');
      return false;
    }

    if (lastNameController.text.trim().isEmpty) {
      ToastMessage.showError('Last name is required');
      return false;
    }

    return true;
  }

  /// Save profile changes
  Future<void> saveProfile(BuildContext context) async {
    if (!validateForm()) return;

    try {
      isLoading.value = true;

      // TODO: Implement actual API call to save profile
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));

      // Show success message
      ToastMessage.showSuccess('Profile updated successfully');

      // Go back to profile screen
      context.pop();
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
  }
}
