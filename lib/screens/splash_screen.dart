import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_page.dart';
import '../widgets/tts_widget.dart';
import '../widgets/language_switch_widget.dart';
import '../providers/language_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  startTimer() async {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const Home())
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 139, 195, 74),
              Color.fromARGB(255, 76, 175, 80),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 50,
              right: 20,
              child: const LanguageSwitchWidget(),
            ),
            
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.agriculture,
                      size: 100,
                      color: Color.fromARGB(255, 255, 152, 0),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    localizations.appTitle,
                    style: languageProvider.isBangla 
                        ? GoogleFonts.notoSansBengali(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          )
                        : GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    localizations.appSubtitle,
                    textAlign: TextAlign.center,
                    style: languageProvider.isBangla 
                        ? GoogleFonts.notoSansBengali(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                          )
                        : GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                          ),
                  ),

                  const SizedBox(height: 30),

                  TTSWidget(
                    text: localizations.splashWelcome,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 30),

                  const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    localizations.splashText,
                    style: languageProvider.isBangla 
                        ? GoogleFonts.notoSansBengali(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.8),
                          )
                        : GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.white.withOpacity(0.8),
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