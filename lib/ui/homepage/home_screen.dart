import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_bloc.dart';
import 'package:studenthub/blocs/theme_bloc/theme_event.dart';
import 'package:studenthub/constants/key_translator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studenthub/ui/homepage/widgets/my_elavated_button.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            child: AppBar(
              title: Text('StudentHub',
                  style: GoogleFonts.martelSans(
                      fontSize: 36,
                      color: const Color(0xFF6188FF),
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 36),
            // decoration: const BoxDecoration(color: Colors.black),
            child: Transform.scale(
              scale: 1.4,
              child: Image.asset(
                'lib/assets/images/landing.png',
              ),
            ),
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: 375,
            child: Text(
              'Build your product with high-skilled student',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xFF848484),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 375,
            child: Text(
              'Find and onboard top-tier students for your projects, enabling them to gain real-world experience and skills',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF848484),
                fontWeight: FontWeight.w400,
                height: 1.3, // Adjust the line height here
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: MyElevatedButton(
              height: 45,
              width: 350,
              gradient: const LinearGradient(
                colors: [Color(0xFFACC0FF), Color(0xFF6188FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onPressed: () {},
              borderRadius: BorderRadius.circular(20),
              child: Text(
                'company'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: MyElevatedButton(
              height: 45,
              width: 350,
              backgroundColor: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              buttonBorder: Border.all(
                color: const Color(0xFF6188FF),
                width: 2,
              ),
              onPressed: () {},
              child: Text(
                'student'.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF6188FF),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(32),
            child: SizedBox(
              width: 350,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'When proceeding to the next step, I agreed to the ',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF848484),
                      ),
                    ),
                    TextSpan(
                      text: 'Terms of Service and Usage Policy.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF848484),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
