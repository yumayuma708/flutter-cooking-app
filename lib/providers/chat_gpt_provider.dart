import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CookingData {
  final List<String> selectedIngredients;
  final List<String> timeConditions;
  final List<String> servingConditions;
  final List<String> cuisineConditions;
  final List<String> sizeConditions;
  final List<String> preferenceConditions;
  final List<String> confirmationConditions;
  final String instruction;

  CookingData({
    required this.selectedIngredients,
    required this.timeConditions,
    required this.servingConditions,
    required this.cuisineConditions,
    required this.sizeConditions,
    required this.preferenceConditions,
    required this.confirmationConditions,
    required this.instruction,
  });

  Map<String, dynamic> toJson() => {
        'ingredients': selectedIngredients,
        'time_conditions': timeConditions,
        'serving_conditions': servingConditions,
        'cuisine_conditions': cuisineConditions,
        'size_conditions': sizeConditions,
        'preference_conditions': preferenceConditions,
        'confirmation_conditions': confirmationConditions,
      };
}

class ChatGPTProvider {
  Future<String> getCookingInstruction(CookingData data) async {
    final apiKey = dotenv.env['API_KEY']!;
    const url = 'https://api.openai.com/v1/chat/completions';
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final prompts = '次に挙げる食材や各条件に従って、料理を作ってください。\n\n'
        '食材：${data.selectedIngredients.join('、')}\n'
        '調理時間：${data.timeConditions.join('、')}\n'
        '人数：${data.servingConditions.join('、')}\n'
        '料理タイプ：${data.cuisineConditions.join('、')}\n'
        '食事量：${data.sizeConditions.join('、')}\n'
        'その他の条件：${data.preferenceConditions.join('、')}\n'
        '確認：${data.confirmationConditions.join('、')}\n\n'
        // 以下、既存のテンプレートを使用
        '答える際は、以下のテンプレートに従ってお答えください。\n\n'
        '表示テンプレートは以下：\n'
        '料理名：〇〇\n'
        '目安時間：◯時間◯分\n'
        '人数：◯人分\n'
        '食材：〇〇、〇〇、〇〇、・・・\n'
        '〇〇：◯g\n'
        '\t〇〇：◯g\n'
        '\t〇〇：◯g\n'
        '作り方：\n'
        '〇〇〇〇〇〇〇〇〇〇\n'
        '〇〇〇〇〇〇〇〇〇〇\n'
        '〇〇〇〇〇〇〇〇〇〇\n'
        'その他料理を作る際に押さえておきたいポイント、料理のアピールポイントなど';

    final body = json.encode({
      'messages': [
        {"role": "user", "content": prompts}
      ],
      'model': "gpt-3.5-turbo",
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to get cooking instruction from ChatGPT: ${response.body}');
    }

    final responseBody = utf8.decode(response.bodyBytes);
    final responseData = json.decode(responseBody);

    if (responseData['choices'] != null &&
        responseData['choices'].isNotEmpty &&
        responseData['choices'][0]['message']['content'] != null) {
      return responseData['choices'][0]['message']['content'].trim();
    } else {
      throw Exception('Unexpected data format from ChatGPT API: $responseData');
    }
  }
}
