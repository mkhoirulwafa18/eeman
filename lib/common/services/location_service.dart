// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_app/common/extensions/text_theme_extension.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/l10n/l10n.dart';

class LocationService {
  Location? currentLocation;

  Future<Location?> getLocation() async {
    final locationPermission = await _requestLocationPermission();
    if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
      return null; // Indicate permission issue
    }

    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await _showLocationServiceAlertDialog();
      return null; // User may need to enable location services
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
    final result = Location(latitude: position.latitude, longitude: position.longitude, timestamp: position.timestamp);
    currentLocation = result;

    return result;
  }

  Future<String?> getCity(Location location) async {
    try {
      final placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
      return placemarks[0].subAdministrativeArea.toString();
    } catch (e) {
      if (e is PlatformException) {
        debugPrint(e.toString());
      }
      return null; // Indicate error
    }
  }

  Future<LocationPermission> _requestLocationPermission() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  Future<void> _showLocationServiceAlertDialog() async {
    await showDialog(
      context: rootNavigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            context.l10n.turnOnLocation,
            style: context.displayLarge,
          ),
          content: Text(
            context.l10n.needLocationServiceWantToEnable,
            style: context.bodySmall,
          ),
          actions: <Widget>[
            OutlinedButton(
              child: Text(
                context.l10n.close,
                style: context.bodySmall,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                'Aktifkan',
                style: context.bodySmall,
              ),
              onPressed: () async {
                await Geolocator.openLocationSettings();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
