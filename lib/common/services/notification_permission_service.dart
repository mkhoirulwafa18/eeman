// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// A service to handle notification permissions in a modern way
/// Compatible with Android 13+ which requires POST_NOTIFICATIONS permission
class NotificationPermissionService {
  /// Singleton instance
  factory NotificationPermissionService() {
    return _instance;
  }

  NotificationPermissionService._internal();

  static final NotificationPermissionService _instance = NotificationPermissionService._internal();

  /// Check if notification permission is granted
  Future<bool> isNotificationPermissionGranted() async {
    return await Permission.notification.isGranted;
  }

  /// Request notification permission
  /// Returns true if permission is granted, false otherwise
  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.status;
    
    // If permission is already granted, return true
    if (status.isGranted) {
      return true;
    }
    
    // If permission is denied but not permanently, request it
    if (status.isDenied) {
      final result = await Permission.notification.request();
      return result.isGranted;
    }
    
    // If permission is permanently denied, open app settings
    if (status.isPermanentlyDenied) {
      return false;
    }
    
    // For other cases (restricted, limited, etc.)
    return false;
  }

  /// Show a dialog to explain why notification permission is needed
  /// and guide the user to app settings if permanently denied
  Future<bool> showPermissionRationaleDialog(BuildContext context) async {
    final status = await Permission.notification.status;
    
    // If already granted, no need for dialog
    if (status.isGranted) return true;
    
    // For permanently denied, show settings dialog
    if (status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      final shouldOpenSettings = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Notification Permission'),
          content: const Text(
            'Notifications are permanently denied. '
            'Please enable them in app settings to receive prayer time alerts.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      
      if (shouldOpenSettings == true) {
        await openAppSettings();
        // Check if permission was granted after returning from settings
        return await Permission.notification.isGranted;
      }
      return false;
    }
    
    // For first time request or previously denied (not permanently)
    // ignore: use_build_context_synchronously
    final shouldRequest = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Allow Notifications'),
        content: const Text(
          'This app needs notification permission to alert you about prayer times. '
          'Would you like to enable notifications?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No Thanks'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Allow'),
          ),
        ],
      ),
    );
    
    if (shouldRequest == true) {
      final result = await Permission.notification.request();
      return result.isGranted;
    }
    
    return false;
  }
}