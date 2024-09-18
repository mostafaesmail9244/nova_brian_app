import 'dart:typed_data';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:nova_brian_app/core/constants/constants.dart';

class GeminiService {
  final Gemini _gemini = Gemini.instance;
  Future<void> init() async {
    Gemini.init(apiKey: Constants.apiKey);
  }

  Future<void> sendMessageToGemini(
      {required String message,
      required List<Uint8List>? images,
      required void Function(Candidates) onData}) async {
    _gemini.streamGenerateContent(message, images: images).listen(onData);
  }
}
