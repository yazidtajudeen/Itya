import 'package:flutter/material.dart';
import 'package:yaz/Presentation/view/select_auth.dart';
import 'package:yaz/themes/colors.dart';
import 'package:yaz/Components/button_component.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
              child: Image.asset(
                'images/restaurant.png',
                width: width,
                height: height * 0.45,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: height * 0.05),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(text: 'Order from your '),
                  TextSpan(
                    text: 'favorite',
                    style: TextStyle(color: AppColors.brightBlue),
                  ),
                  const TextSpan(text: '\nfood vendors'),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Text(
                "With one click place orders for your favorite dishes\nand frequent meals from any food vendor.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: height * 0.07),
            CustomButton(
              text: 'Get Started',
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectAuth()));
              },
              color: AppColors.navyBlue,
              borderRadius: 20,
              width: width * 0.8,
              height: height * 0.07,
              icon: Icons.arrow_forward,
              textstyle: TextStyle(color: Colors.white, fontSize: width * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}
