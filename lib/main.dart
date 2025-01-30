import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaz/Presentation/get_started.dart';
import 'package:yaz/Presentation/view/Splash.dart';
import 'package:yaz/Presentation/view/onboarding_one.dart';
import 'package:yaz/Presentation/view/onboarding_two.dart';
import 'package:yaz/Presentation/view/select_auth.dart';
import 'package:yaz/Presentation/view/select_location.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  const String supabaseUrl = 'https://pptltztgxybtxqbyslpk.supabase.co';
  const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBwdGx0enRneHlidHhxYnlzbHBrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyMzU4NjYsImV4cCI6MjA1MzgxMTg2Nn0.sGKrUNstyRxjBgxcckBvraAoJxI4ogNVmbjm8bg_Lrg';
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
        initialRoute: "/splash",
        routes: {
          "/splash": (context) => const Splash(),
          "/onboarding_one": (context) => const OnboardingOne(),
          "/onboarding_two": (context) => const OnboardingTwo(),
          "/select_location": (context) => const SelectLocation(),
          "/get_started": (context) => const GetStarted(),
          "/select_auth": (context) => const SelectAuth(),
        });
  }
}
