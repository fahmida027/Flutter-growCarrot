import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/tts_widget.dart';
import '../widgets/language_switch_widget.dart';
import '../providers/language_provider.dart';

class StageDetails extends StatefulWidget {
  final String name;
  final String description;
  final int stageNumber;

  const StageDetails({
    super.key,
    required this.name,
    required this.description,
    required this.stageNumber,
  });

  @override
  State<StageDetails> createState() => _StageDetailsState();
}

class _StageDetailsState extends State<StageDetails> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var fontSize = screenWidth > 600 ? 18.0 : 16.0;

    final languageProvider = Provider.of<LanguageProvider>(context);
    final localizations = AppLocalizations.of(context)!;

    // Define stage-specific colors and icons
    List<Color> stageColors = [
      const Color.fromARGB(255, 141, 110, 99),
      const Color.fromARGB(255, 139, 195, 74),
      const Color.fromARGB(255, 255, 193, 7),
      const Color.fromARGB(255, 33, 150, 243),
      const Color.fromARGB(255, 244, 67, 54),
      const Color.fromARGB(255, 76, 175, 80),
      const Color.fromARGB(255, 104, 159, 56),
      const Color.fromARGB(255, 233, 30, 99),
      const Color.fromARGB(255, 255, 152, 0),
      const Color.fromARGB(255, 255, 87, 34),
      const Color.fromARGB(255, 63, 81, 181),
    ];

    List<IconData> stageIcons = [
      Icons.terrain,
      Icons.eco,
      Icons.wb_sunny,
      Icons.water_drop,
      Icons.bug_report,
      Icons.nature_people,
      Icons.park,
      Icons.local_florist,
      Icons.schedule,
      Icons.agriculture,
      Icons.storefront,
    ];

    Color stageColor =
        stageColors[(widget.stageNumber - 1) % stageColors.length];
    IconData stageIcon =
        stageIcons[(widget.stageNumber - 1) % stageIcons.length];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: stageColor,
        title: Text(
          "${localizations.step} ${widget.stageNumber}",
          style: languageProvider.isBangla
              ? GoogleFonts.notoSansBengali(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              : GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: const LanguageSwitchWidget(),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              stageColor,
              stageColor.withOpacity(0.1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header section with icon and TTS
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: stageColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        stageIcon,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: languageProvider.isBangla
                          ? GoogleFonts.notoSansBengali(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )
                          : GoogleFonts.poppins(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${localizations.step} ${widget.stageNumber} ${localizations.ofSteps}",
                        style: languageProvider.isBangla
                            ? GoogleFonts.notoSansBengali(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              )
                            : GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // TTS Widget for the stage title
                    TTSWidget(
                      text: "${widget.name} - ${widget.description}",
                      color: Colors.white,
                    ),
                  ],
                ),
              ),

              // Description section
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  elevation: 8,
                  shadowColor: stageColor.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: stageColor,
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              localizations.stageInfo,
                              style: languageProvider.isBangla
                                  ? GoogleFonts.notoSansBengali(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: stageColor,
                                    )
                                  : GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: stageColor,
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.description,
                          textAlign: TextAlign.justify,
                          style: languageProvider.isBangla
                              ? GoogleFonts.notoSansBengali(
                                  fontSize: fontSize,
                                  height: 1.8,
                                  color: Colors.grey[800],
                                )
                              : GoogleFonts.poppins(
                                  fontSize: fontSize,
                                  height: 1.6,
                                  color: Colors.grey[800],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Quick tips section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: stageColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: stageColor,
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              localizations.quickTip,
                              style: languageProvider.isBangla
                                  ? GoogleFonts.notoSansBengali(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: stageColor,
                                    )
                                  : GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: stageColor,
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _getQuickTip(widget.stageNumber, localizations),
                          style: languageProvider.isBangla
                              ? GoogleFonts.notoSansBengali(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                  height: 1.6,
                                )
                              : GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                  height: 1.6,
                                ),
                        ),
                        const SizedBox(height: 12),
                        // TTS Widget for quick tips
                        TTSWidget(
                          text: _getQuickTip(widget.stageNumber, localizations),
                          color: stageColor,
                        ),
                        const SizedBox(height: 12),

                        ElevatedButton.icon(
                          onPressed: () async {
                            String url = _getYoutubeLink(
                                widget.stageNumber, languageProvider.isBangla);
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Could not launch YouTube link')),
                              );
                            }
                          },
                          icon: const Icon(Icons.play_circle_fill,
                              color: Colors.white),
                          label: Text(
                            languageProvider.isBangla
                                ? "ভিডিও দেখুন"
                                : "See Videos",
                            style: languageProvider.isBangla
                                ? GoogleFonts.notoSansBengali(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )
                                : GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Navigation buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    if (widget.stageNumber > 1)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: Text(
                            localizations.previous,
                            style: languageProvider.isBangla
                                ? GoogleFonts.notoSansBengali()
                                : GoogleFonts.poppins(),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    if (widget.stageNumber > 1 && widget.stageNumber < 11)
                      const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(
                          localizations.backToStages,
                          style: languageProvider.isBangla
                              ? GoogleFonts.notoSansBengali()
                              : GoogleFonts.poppins(),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: stageColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  String _getQuickTip(int stageNumber, AppLocalizations localizations) {
    List<String> tips = [
      localizations.tip1,
      localizations.tip2,
      localizations.tip3,
      localizations.tip4,
      localizations.tip5,
      localizations.tip6,
      localizations.tip7,
      localizations.tip8,
      localizations.tip9,
      localizations.tip10,
      localizations.tip11,
    ];

    return tips[stageNumber - 1];
  }

  String _getYoutubeLink(int stageNumber, bool isBangla) {
    List<String> englishLinks = [
      "https://youtu.be/woC0lCb5ois?si=W-X4YfvMoq4cILAr",
      "https://youtube.com/shorts/PEHpoDn0Xjc?si=UXSz6QzImoKp3S7Y",
      "https://youtu.be/n_-NQxK2keE?si=r3wqOt1k0LIBPhDk",
      "https://youtube.com/shorts/HAm8LF8Jxds?si=YTpT69IO3bujYKIR",
      "https://youtu.be/rVWQP5iZr0U?si=cMpplJBjYy3y1woM",
      "https://youtu.be/GE9gQvWvZAQ?si=r7dMu3R0oT8dhJWX",
      "https://youtu.be/GdM08t2CzEU?si=_60ZbmHJDvXcQDlO",
      "https://youtube.com/shorts/OJ5s4iIsnoo?si=LHW8yb1mkFlXrAIn",
      "https://youtu.be/HBw19-wAFzA?si=d1QEKOgckAb3f_Kz",
      "https://youtu.be/WJN6ZVV4LCo?si=0Dd4Jh-B3RSNeouv",
      "https://youtu.be/xcvHPo4XxDM?si=OUUSQafTOpre-KBK1",
    ];

    List<String> banglaLinks = [
      "https://youtube.com/shorts/pv0sJYVYVpY?si=fICgSf0kplCkOfde",
      "https://youtu.be/OPjyxI5YGHA?si=MugeXBaD45gjpzWh",
      "https://youtube.com/shorts/RYmNVay9S8Y?si=SFAS6FQ0aP2lmqoa",
      "https://youtu.be/JGkeT9WjYmU?si=jdkYoevfWms0IpuW",
      "https://youtube.com/shorts/f2t40Qfs16k?si=cTkbBhUj3mXOoXVZ",
      "https://youtu.be/-K431VxUm_Q?si=2MYus1ivnimxGtZ1",
      "https://youtu.be/wRVqB7x6ngs?si=B2-NFr4dZ2laA5kW",
      "https://youtube.com/shorts/2lCjulymooE?si=lGkSe8dlnSiSk2RY",
      "https://youtube.com/shorts/ijzCnrniuRk?si=96s0Mu6vXcpMZzk2",
      "https://youtu.be/-K431VxUm_Q?si=2MYus1ivnimxGtZ1",
      "https://youtu.be/jWtDQub9N9k?si=bo497aYv6pL5StWy",
    ];

    return isBangla
        ? banglaLinks[stageNumber - 1]
        : englishLinks[stageNumber - 1];
  }
}
