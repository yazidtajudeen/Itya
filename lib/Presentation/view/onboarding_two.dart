import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:yaz/Presentation/get_started.dart';
import 'package:yaz/themes/colors.dart';
import 'package:yaz/Components/button_component.dart';

class OnboardingTwo extends StatefulWidget {
  const OnboardingTwo({super.key});

  @override
  State<OnboardingTwo> createState() => _OnboardingTwoState();
}

class _OnboardingTwoState extends State<OnboardingTwo> {
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackbar('Location services are disabled. Please enable them.');
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackbar('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackbar('Location permissions are permanently denied.');
      return;
    }

    try {
      LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 0,
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      _showSnackbar('Location: ${position.latitude}, ${position.longitude}');
      _navigateToGetStarted();
    } catch (e) {
      _showSnackbar('Error fetching location: $e');
    }
  }

  void _showSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _navigateToGetStarted() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStarted(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.8, height * 0.05, 0, 0),
            child: TextButton(
              onPressed: _navigateToGetStarted,
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: AppColors.brightBlue,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.07),
          SizedBox(
            width: width * 0.8,
            height: height * 0.35,
            child: const Image(
              image: AssetImage('images/locator.png'),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: height * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: 'Locate '),
                      TextSpan(
                        text: 'food ',
                        style: TextStyle(color: AppColors.brightBlue),
                      ),
                      const TextSpan(text: 'vendors'),
                      const TextSpan(text: '\nnear you!'),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "We'll find easy ideas for meals that taste amazing,\nget ready to discover delicious\nthings that you and everyone will love!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.02,
                height: width * 0.02,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: width * 0.02),
              Container(
                width: width * 0.06,
                height: width * 0.02,
                decoration: BoxDecoration(
                  color: AppColors.brightBlue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.05),
          CustomButton(
            text: 'Allow Location Access',
            onPressed: _getCurrentLocation,
            color: AppColors.navyBlue,
            borderRadius: 18,
            width: width * 0.85,
            height: height * 0.08,
            textstyle: TextStyle(color: Colors.white, fontSize: width * 0.04),
          ),
        ],
      ),
    );
  }
}
