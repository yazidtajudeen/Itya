import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yaz/Presentation/get_started.dart';
import 'package:yaz/Presentation/view/Splash.dart';
import 'package:yaz/Presentation/view/onboarding_one.dart';
import 'package:yaz/Presentation/view/onboarding_two.dart';
import 'package:yaz/Presentation/view/select_location.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  const String supabaseUrl = 'https://bwnyosocxcecojsozqdg.supabase.co';
  const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ3bnlvc29jeGNlY29qc296cWRnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU4NjA2MDEsImV4cCI6MjA1MTQzNjYwMX0.cBg6bJfc3u8uNHrx5kzU6-fEKM08TpCKH_AfQTMPC1E';
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        });
  }
}
