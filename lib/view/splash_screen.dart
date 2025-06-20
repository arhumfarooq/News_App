import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

// import your home screen here
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to Home after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // replace with your screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/splash_pic.png",
              fit: BoxFit.cover,
              height: screenheight * 0.5,
            ),
            SizedBox(height: screenheight * 0.04),
            Text(
              "TOP HEADLINES",
              style: GoogleFonts.anton(
                letterSpacing: .6,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenheight * 0.04),
            SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
