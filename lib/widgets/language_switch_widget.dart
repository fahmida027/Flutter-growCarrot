import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class LanguageSwitchWidget extends StatelessWidget {
  final Color? iconColor;
  final Color? textColor;
  final bool showText;

  const LanguageSwitchWidget({
    super.key,
    this.iconColor,
    this.textColor,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return GestureDetector(
          onTap: () {
            _showLanguageDialog(context, languageProvider);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language,
                  color: iconColor ?? Colors.white,
                  size: 18,
                ),
                if (showText) ...[
                  const SizedBox(width: 6),
                  Text(
                    languageProvider.getLanguageName(),
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context, LanguageProvider languageProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.language, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              languageProvider.isBangla ? 'ভাষা নির্বাচন' : 'Select Language',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('English'),
              trailing: languageProvider.getLanguageCode() == 'en' 
                  ? const Icon(Icons.radio_button_checked, color: Colors.green)
                  : const Icon(Icons.radio_button_unchecked),
              onTap: () {
                languageProvider.setLanguage(const Locale('en'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('বাংলা'),
              trailing: languageProvider.getLanguageCode() == 'bn' 
                  ? const Icon(Icons.radio_button_checked, color: Colors.green)
                  : const Icon(Icons.radio_button_unchecked),
              onTap: () {
                languageProvider.setLanguage(const Locale('bn'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              languageProvider.isBangla ? 'বাতিল' : 'Cancel',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}