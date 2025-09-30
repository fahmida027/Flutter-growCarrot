import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'stage_details.dart';
import '../widgets/tts_widget.dart';
import '../widgets/language_switch_widget.dart';
import '../providers/language_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.agriculture, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            Text(
              localizations.appTitle,
              style: languageProvider.isBangla
                  ? GoogleFonts.notoSansBengali(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    )
                  : GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 76, 175, 80),
        elevation: 4,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: LanguageSwitchWidget(),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    localizations.aboutApp,
                    style: languageProvider.isBangla
                        ? GoogleFonts.notoSansBengali()
                        : GoogleFonts.poppins(),
                  ),
                  content: Text(
                    localizations.aboutDescription,
                    style: languageProvider.isBangla
                        ? GoogleFonts.notoSansBengali()
                        : GoogleFonts.poppins(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        localizations.ok,
                        style: languageProvider.isBangla
                            ? GoogleFonts.notoSansBengali()
                            : GoogleFonts.poppins(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 240, 248, 255),
              Color.fromARGB(255, 232, 245, 233),
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    localizations.farmingStages,
                    style: languageProvider.isBangla
                        ? GoogleFonts.notoSansBengali(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 76, 175, 80),
                          )
                        : GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 76, 175, 80),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.followSteps,
                    textAlign: TextAlign.center,
                    style: languageProvider.isBangla
                        ? GoogleFonts.notoSansBengali(
                            fontSize: 14,
                            color: Colors.grey[600],
                          )
                        : GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                  ),
                  const SizedBox(height: 16),
                  TTSWidget(
                    text:
                        "${localizations.farmingStages} - ${localizations.followSteps}",
                    color: const Color.fromARGB(255, 76, 175, 80),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                padding: const EdgeInsets.all(16),
                childAspectRatio: 0.75,
                children: List.generate(11, (index) {
                  return _buildStageCard(
                      context, index + 1, localizations, languageProvider);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageCard(BuildContext context, int stageNumber,
      AppLocalizations localizations, LanguageProvider languageProvider) {
    List<Color> stageColors = [
      const Color.fromARGB(255, 141, 110, 99), // Soil - Brown
      const Color.fromARGB(255, 139, 195, 74), // Seed - Light Green
      const Color.fromARGB(255, 255, 193, 7), // Growth Conditions - Yellow
      const Color.fromARGB(255, 33, 150, 243), // Water - Blue
      const Color.fromARGB(255, 244, 67, 54), // Pest - Red
      const Color.fromARGB(255, 76, 175, 80), // Care - Green
      const Color.fromARGB(255, 104, 159, 56), // Growth - Dark Green
      Color.fromARGB(255, 247, 134, 171), // Flowering - Pink
      const Color.fromARGB(255, 255, 152, 0), // Ripening - Orange
      const Color.fromARGB(255, 255, 87, 34), // Harvest - Deep Orange
      const Color.fromARGB(255, 63, 81, 181), // Market - Indigo
    ];

    List<String> stageNames = [
      localizations.stage1Name,
      localizations.stage2Name,
      localizations.stage3Name,
      localizations.stage4Name,
      localizations.stage5Name,
      localizations.stage6Name,
      localizations.stage7Name,
      localizations.stage8Name,
      localizations.stage9Name,
      localizations.stage10Name,
      localizations.stage11Name,
    ];

    List<String> descriptions = [
      localizations.description1,
      localizations.description2,
      localizations.description3,
      localizations.description4,
      localizations.description5,
      localizations.description6,
      localizations.description7,
      localizations.description8,
      localizations.description9,
      localizations.description10,
      localizations.description11,
    ];

    String stageName = stageNames[stageNumber - 1];
    String description = descriptions[stageNumber - 1];
    Color cardColor = stageColors[(stageNumber - 1) % stageColors.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StageDetails(
              name: stageName,
              description: description,
              stageNumber: stageNumber,
            ),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shadowColor: cardColor.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                cardColor,
                cardColor.withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      "images/stage_$stageNumber.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.agriculture,
                          size: 35,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  stageName,
                  textAlign: TextAlign.center,
                  style: languageProvider.isBangla
                      ? GoogleFonts.notoSansBengali(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        )
                      : GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${localizations.step} $stageNumber",
                  style: languageProvider.isBangla
                      ? GoogleFonts.notoSansBengali(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        )
                      : GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
