import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaz/Components/button_component.dart';
import 'package:yaz/Presentation/view/Home.dart';
import 'package:yaz/Presentation/view/signup.dart';
import 'package:yaz/themes/colors.dart';
import 'package:logger/logger.dart';

class SelectAuth extends StatefulWidget {
  const SelectAuth({super.key});

  @override
  State<SelectAuth> createState() => _SelectAuthState();
}

class _SelectAuthState extends State<SelectAuth>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.7, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _googleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        logger.w('Google Sign-In was canceled.');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        if (mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Home()));
        }
      }
    } catch (error) {
      logger.e('Google Sign-In Error: $error');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In failed: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.09),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.11),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: SizedBox(
                      width: 275,
                      height: 276,
                      child: Image.asset('images/auth.png'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.05),
            Text(
              'Create An Account',
              style: TextStyle(
                  fontSize: width * 0.07, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: height * 0.02),
            Text(
              'Register/Login to continue using the app',
              style: TextStyle(
                  fontSize: width * 0.03, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: height * 0.05),
            CustomButton(
              text: 'Sign Up',
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Signup()));
              },
              borderRadius: 20,
              width: width * 0.8,
              height: height * 0.07,
              textstyle: TextStyle(fontSize: width * 0.04, color: Colors.white),
            ),
            SizedBox(height: height * 0.03),
            GestureDetector(
              onTap: _googleSignIn, // Using Firebase Google Sign-In
              child: Container(
                width: width * 0.8,
                height: height * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.lightGrayText),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        'images/google.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      'Sign Up with Google',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
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
