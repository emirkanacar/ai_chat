import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey = dotenv.env["GEMINI_API_KEY"].toString();
  GenerativeModel? model;
  GenerativeModel? visionModel;

  void init() {
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    visionModel = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
  }

  Future<GenerateContentResponse?> textPrompt(String prompt) async {
    final generateContent = [Content.text(prompt)];

    return await model?.generateContent(generateContent);
  }

  Future<GenerateContentResponse?> imagePrompt(String prompt, List<ByteData> images) async {
    final content = [
      Content.multi([
        TextPart(prompt),
        ...images.map((e) => DataPart("image/jpeg", e.buffer.asUint8List()))
      ])
    ];

    return await visionModel?.generateContent(content);
  }


}