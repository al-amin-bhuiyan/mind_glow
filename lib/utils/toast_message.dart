import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Toast Message Utility - Displays toast notifications
class ToastMessage {
  ToastMessage._();

  /// Show success toast
  static void showSuccess(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show error toast
  static void showError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show info toast
  static void showInfo(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.blue.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// Show warning toast
  static void showWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.orange.withValues(alpha: 0.8),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
