import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:questionnaire/app/core/theme/app_theme.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSettingsDialog(
        'Location Services Disabled',
        'Please enable location services to record your submission location.',
        openLocationSettings: true,
      );
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSettingsDialog(
          'Location Permission Denied',
          'Location permission is required to record your submission location. Please grant the permission.',
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSettingsDialog(
        'Permission Permanently Denied',
        'Location permission is permanently denied. Please go to Settings and enable it manually.',
        openAppSettings: true,
      );
      return null;
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  static void _showSettingsDialog(
    String title,
    String message, {
    bool openAppSettings = false,
    bool openLocationSettings = false,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(100, 40),
            ),
            onPressed: () async {
              Get.back();
              if (openAppSettings) {
                await Geolocator.openAppSettings();
              } else if (openLocationSettings) {
                await Geolocator.openLocationSettings();
              }
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
