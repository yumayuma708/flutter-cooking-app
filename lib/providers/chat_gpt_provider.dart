import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatGPTProvider {
  Future<String> getCookingInstruction(CookingData data) async {
    final apiKey = dotenv.env['API_KEY']!;
    final url = 'https://api.openai.com/v2/engines/davinci/completions';
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final prompt = '次に挙げる食材や各条件に従って、料理を作ってください。\n\n'
        '食材：${data.ingredients.join('、')}\n'
        '条件：${data.situations.join('、')}\n\n'
        '答える際は、以下のテンプレートに従ってお答えください。\n\n'
        '表示テンプレートは以下：\n'
        '料理名：〇〇\n'
        '目安時間：◯時間◯分\n'
        '人数：◯人分\n'
        '食材：\n'
        '〇〇：◯g\n'
        '\t〇〇：◯g\n'
        '\t〇〇：◯g\n'
        '作り方：\n'
        '〇〇〇〇〇〇〇〇〇〇\n'
        '〇〇〇〇〇〇〇〇〇〇\n'
        '〇〇〇〇〇〇〇〇〇〇\n'
        'その他料理を作る際に押さえておきたいポイント、料理のアピールポイントなど';

    final body = json.encode({
      'prompt': prompt,
      'max_tokens': 300,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    final responseData = json.decode(response.body);
    return responseData['choices'][0]['text'].trim();
  }
}
