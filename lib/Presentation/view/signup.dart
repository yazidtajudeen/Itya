import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yaz/Components/text_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
            SizedBox(
              height: height * 0.09,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: height * 0.14),
                child: SizedBox(
                  width: 210,
                  height: 197,
                  child: Image.asset('images/signin.png'),
                )),
            SizedBox(
              height: height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: width * 0.07),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
