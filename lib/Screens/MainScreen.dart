import 'package:dayglow/Screens/LocationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart' as rive;

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background animation filling the screen
            Positioned.fill(
              child: rive.RiveAnimation.asset(
                "assets/animation/r1.riv",
                fit: BoxFit.cover, // Ensures the animation covers the screen
              ),
            ),
            // Foreground content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Weather Lyric",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 168, 146, 135),
                      fontSize: 30.sp, // Responsive font size
                    ),
                  ),
                  SizedBox(height: 400.h), // Responsive spacing

                  // Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => LocationScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50.h, // Responsive height
                      width: 200.w, // Responsive width
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius:
                            BorderRadius.circular(30.r), // Responsive radius
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp, // Responsive font size
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
