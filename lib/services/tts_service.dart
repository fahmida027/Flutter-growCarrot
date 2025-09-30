import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final TTSService _instance = TTSService._internal();
  factory TTSService() => _instance;
  TTSService._internal();

  late FlutterTts _flutterTts;
  bool _isPlaying = false;
  bool _isPaused = false;
  String _currentLanguage = 'en';

  bool get isPlaying => _isPlaying;
  bool get isPaused => _isPaused;

  Future<void> init() async {
    _flutterTts = FlutterTts();
    
    await setLanguage('en');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    
    _flutterTts.setStartHandler(() {
      _isPlaying = true;
      _isPaused = false;
    });

    _flutterTts.setCompletionHandler(() {
      _isPlaying = false;
      _isPaused = false;
    });

    _flutterTts.setCancelHandler(() {
      _isPlaying = false;
      _isPaused = false;
    });

    _flutterTts.setPauseHandler(() {
      _isPaused = true;
    });

    _flutterTts.setContinueHandler(() {
      _isPaused = false;
    });
  }

  Future<void> setLanguage(String languageCode) async {
    if (_currentLanguage != languageCode) {
      _currentLanguage = languageCode;
      
      if (languageCode == 'bn') {
        await _flutterTts.setLanguage('bn-IN'); 
        await _flutterTts.setSpeechRate(0.3); 
      } else {
        await _flutterTts.setLanguage('en-US'); 
        await _flutterTts.setSpeechRate(1);
      }
    }
  }

  Future<void> speak(String text, {String? languageCode}) async {
    if (text.isNotEmpty) {
      if (languageCode != null) {
        await setLanguage(languageCode);
      }
      await _flutterTts.speak(text);
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    _isPlaying = false;
    _isPaused = false;
  }

  Future<void> pause() async {
    await _flutterTts.pause();
  }

  void dispose() {
    _flutterTts.stop();
  }
}