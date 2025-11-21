// flutter radio app with just radio package

import 'package:flutter/material.dart';
import 'package:just_radio/constants/colors.dart';
import 'package:just_radio/views/radio_page/radio_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Radio App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.primary),
              useMaterial3: true,
              // Optional: Make the background of the "empty space" dark on large screens
              scaffoldBackgroundColor: Colors.white,
            ),

            // ------ set max width 1080px for web
            builder: (context, child) {
              return Container(
                // This color fills the empty space on large screens (left/right of the app)
                color: Colors.grey[200],
                alignment: Alignment.center, // Centers the app on the monitor
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1080), // Sets the limit
                  child: child, // This represents the active page (RadioPage)
                ),
              );
            },
            // ----
            home: const RadioPage(),
          );
        }
    );
  }
}

// change app icon:
// android/app/src/main/res/ icons are in minmap folders, change them, online generator
// windows/runner/resources/ change app_icon.ico