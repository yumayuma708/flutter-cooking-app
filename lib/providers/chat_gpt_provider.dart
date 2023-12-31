import 'package:caul/providers/chat_gpt_devider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CookingData {
  final List<String> selectedVegetables;
  final List<String> selectedSeasonings;
  final List<String> timeConditions;
  final List<String> servingConditions;
  final List<String> cuisineType;
  final List<String> sizeConditions;
  final List<String> preferenceConditions;
  final List<String> confirmationConditions;
  final String instruction;

  final Map<String, Set<String>> selectedHeaders;

  CookingData({
    required this.selectedVegetables,
    required this.selectedSeasonings,
    required this.timeConditions,
    required this.servingConditions,
    required this.cuisineType,
    required this.sizeConditions,
    required this.preferenceConditions,
    required this.confirmationConditions,
    required this.instruction,
    required this.selectedHeaders,
  });

  Map<String, dynamic> toJson() => {
        'ingredients': selectedVegetables,
        'seasonings': selectedSeasonings,
        'time_conditions': timeConditions,
        'serving_conditions': servingConditions,
        'cuisine_conditions': cuisineType,
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

    String confirmationMessage = '食材にないものを追加して作ってもかまいません。';
    if (data.confirmationConditions.contains('はい')) {
      confirmationMessage = '食材にないものを追加して作っても構いません。';
    } else if (data.confirmationConditions.contains('いいえ')) {
      confirmationMessage = '食材として挙げたもののみで作ってください。';
    }

    String seasoningMessage;
    if (data.selectedSeasonings.contains('おまかせ') ||
        data.selectedSeasonings.isEmpty) {
      seasoningMessage = '調味料は自由に使ってかまいません。';
    } else {
      seasoningMessage = '調味料として、${data.selectedSeasonings.join('、')}を使ってください。';
    }

    final prompts = '次に挙げる食材や各条件に従って、料理を作ってください。\n\n'
        '食材：${data.selectedVegetables.join('、')}\n'
        '$seasoningMessage\n'
        '調理時間：${data.timeConditions.isNotEmpty ? data.timeConditions.join('、') : '指定しない'}\n'
        '人数：${data.servingConditions.isNotEmpty ? data.servingConditions.join('、') : '1人分'}\n'
        '料理タイプ：${data.cuisineType.isNotEmpty ? data.cuisineType.join('、') : '指定しない'}\n'
        '食事量：${data.sizeConditions.isNotEmpty ? data.sizeConditions.join('、') : '指定しない'}\n'
        'その他の条件：${data.preferenceConditions.isNotEmpty ? data.preferenceConditions.join('、') : '指定しない'}\n'
        '$confirmationMessage\n\n'
        '答える際は、以下のテンプレートに従ってお答えください。\n\n'
        '表示テンプレートは以下：\n'
        '料理名：〇〇\n'
        '目安時間：◯時間◯分\n'
        '人数：◯人分\n'
        '材料\n'
        '\t〇〇:◯g\n'
        '\t〇〇:◯g\n'
        '\t〇〇:◯g\n'
        '作り方\n'
        '1."   "\n'
        '2."   "\n'
        '3."   "\n'
        '料理のアピールポイント:"   "\n'
        '※前回までのメッセージを考慮せずに、今回のメッセージのみ考慮して作成してください。\n'
        '※「：」は全て全角を使用してください。';

    debugPrint('Sending the following to ChatGPT:');
    debugPrint(prompts);

    final body = json.encode({
      'messages': [
        {"role": "user", "content": prompts}
      ],
      'model': "gpt-3.5-turbo",
      'temperature': 0.7,
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
      String instruction =
          responseData['choices'][0]['message']['content'].trim();

      final dividedData = ChatGPTDividedData.parseFromInstruction(instruction);
      debugPrint('料理名: ${dividedData.dishName}');
      debugPrint('目安時間: ${dividedData.estimatedTime}');
      debugPrint('人数: ${dividedData.numberOfPeople}');
      debugPrint('材料: ${dividedData.ingredients}');
      debugPrint('作り方: ${dividedData.recipe}');
      debugPrint('料理のアピールポイント: ${dividedData.appealPoint}');

      return instruction;
    } else {
      throw Exception('Unexpected data format from ChatGPT API: $responseData');
    }
  }
}
