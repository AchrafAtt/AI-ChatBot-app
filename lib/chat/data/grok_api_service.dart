import 'dart:convert';
import 'package:http/http.dart' as http;

class GroqApiService {
  static const String _baseUrl =
      "https://api.groq.com/openai/v1/chat/completions"; // Verify this
  static const String _model =
      "llama-3.3-70b-versatile"; // Verify actual model name
  static const int _maxTokens = 2048; // More typical value, adjust as needed

  final String _apiKey;

  GroqApiService({required String apiKey}) : _apiKey = apiKey;

  Future<String> sendMessage(String content) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        }, // Fixed extra space
        body: jsonEncode({
          "model": _model,
          "messages": [
            {"role": "user", "content": content},
          ],
          "max_tokens": _maxTokens,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Adjust based on actual API response structure
        if (data['choices'] != null && data['choices'].isNotEmpty) {
          return data['choices'][0]['message']['content'] ?? 'No content';
        }
        throw Exception('Invalid response structure');
      } else {
        throw Exception(
          'API request failed: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('API error: $e');
    }
  }
}
