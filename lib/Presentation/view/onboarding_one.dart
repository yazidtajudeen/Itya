import 'package:flutter/material.dart';
import 'package:yaz/Presentation/view/onboarding_two.dart';
import 'package:yaz/themes/colors.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(314, 35, 0, 0),
              child: TextButton(
                onPressed: _navigateToNextPage,
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: AppColors.brightBlue,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 300,
              height: 315,
              child: Image(
                image: AssetImage('images/onboarding.png'),
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
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
                const SizedBox(width: 8),
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
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
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
                  const SizedBox(height: 15),
                  const Text(
                    "We'll find easy ideas for meals that taste amazing,\nget ready to discover delicious\nthings that you and everyone will love!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: _navigateToNextPage,
              child: Container(
                width: 325,
                height: 57,
                decoration: BoxDecoration(
                  color: AppColors.navyBlue,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 16,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
