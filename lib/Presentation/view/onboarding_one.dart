import 'package:flutter/material.dart';
import 'package:yaz/Presentation/view/onboarding_two.dart';
import 'package:yaz/themes/colors.dart';
import 'package:yaz/Components/button_component.dart'; // Import your CustomButton component

class OnboardingOne extends StatefulWidget {
  const OnboardingOne({super.key});

  @override
  State<OnboardingOne> createState() => _OnboardingOneState();
}

class _OnboardingOneState extends State<OnboardingOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _indicatorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _indicatorAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextPage() {
    _controller.forward().then((_) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const OnboardingTwo(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.8, height * 0.05, 0, 0),
              child: TextButton(
                onPressed: _navigateToNextPage,
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
            SizedBox(height: height * 0.02),
            SizedBox(
              width: width * 0.8,
              height: height * 0.35,
              child: const Image(
                image: AssetImage('images/onboarding.png'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _indicatorAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 24 - (_indicatorAnimation.value * 16),
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.brightBlue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
                SizedBox(width: width * 0.02),
                AnimatedBuilder(
                  animation: _indicatorAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 8 + (_indicatorAnimation.value * 16),
                      height: 8,
                      decoration: BoxDecoration(
                        color: _indicatorAnimation.value >= 0.5
                            ? AppColors.brightBlue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
              ],
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
                        const TextSpan(text: 'Lets explore '),
                        TextSpan(
                          text: 'delicious',
                          style: TextStyle(color: AppColors.brightBlue),
                        ),
                        const TextSpan(text: '\nmeals'),
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
            SizedBox(height: height * 0.07),
            CustomButton(
              text: 'Next',
              onPressed: _navigateToNextPage,
              color: AppColors.navyBlue,
              borderRadius: 18,
              width: width * 0.85,
              height: height * 0.08,
              icon: Icons.arrow_forward,
              textstyle: TextStyle(color: Colors.white, fontSize: width * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}
