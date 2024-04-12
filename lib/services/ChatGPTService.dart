
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatGPTService {
  final String apiKey = dotenv.env["OPENAI_API_KEY"].toString();
  OpenAI? openAI;

  void init() {
    openAI = OpenAI.instance.build(
      token: apiKey,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 30)),
      enableLog: false
    );
  }

  Future<String> generateTextContent(String prompt) async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": prompt})
    ], maxToken: 200, model: Gpt4VisionPreviewChatModel());

    final response = await openAI?.onChatCompletion(request: request);

    return response?.choices[0].message?.content ?? "";
  }
}