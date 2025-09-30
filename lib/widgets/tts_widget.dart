import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/tts_service.dart';
import '../providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TTSWidget extends StatefulWidget {
  final String text;
  final Color? color;

  const TTSWidget({
    super.key,
    required this.text,
    this.color,
  });

  @override
  State<TTSWidget> createState() => _TTSWidgetState();
}

class _TTSWidgetState extends State<TTSWidget> {
  final TTSService _ttsService = TTSService();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final localizations = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: (widget.color ?? Colors.blue).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (widget.color ?? Colors.blue).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.volume_up,
            color: widget.color ?? Colors.blue,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            localizations.listen,
            style: TextStyle(
              color: widget.color ?? Colors.blue,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (_ttsService.isPlaying) {
                _ttsService.stop();
              } else {
                _ttsService.speak(
                  widget.text, 
                  languageCode: languageProvider.getLanguageCode()
                );
              }
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: widget.color ?? Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _ttsService.isPlaying ? Icons.stop : Icons.play_arrow,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}