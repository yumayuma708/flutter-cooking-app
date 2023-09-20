class ChatGPTDividedData {
  final String dishName;
  final String estimatedTime;
  final String numberOfPeople;
  final String ingredients;
  final String recipe;
  final String appealPoint;

  ChatGPTDividedData({
    required this.dishName,
    required this.estimatedTime,
    required this.numberOfPeople,
    required this.ingredients,
    required this.recipe,
    required this.appealPoint,
  });

  static ChatGPTDividedData parseFromInstruction(String instruction) {
    // テンプレートに基づいて文字列を分割します。
    final dishName = _parseByPrefix(instruction, '料理名：');
    final estimatedTime = _parseByPrefix(instruction, '目安時間：');
    final numberOfPeople = _parseByPrefix(instruction, '人数：');
    final ingredients = _parseByPrefix(instruction, '材料');
    final recipe =
        _parseByPrefix(instruction, '作り方：', nextPrefix: '料理のアピールポイント:');
    final appealPoint = _parseByPrefix(instruction, '料理のアピールポイント:');

    return ChatGPTDividedData(
      dishName: dishName,
      estimatedTime: estimatedTime,
      numberOfPeople: numberOfPeople,
      ingredients: ingredients,
      recipe: recipe,
      appealPoint: appealPoint,
    );
  }

  static String _parseByPrefix(String data, String prefix,
      {String? nextPrefix}) {
    final startIndex = data.indexOf(prefix);
    if (startIndex == -1) return '';
    final nextIndex = nextPrefix == null
        ? -1
        : data.indexOf(nextPrefix, startIndex + prefix.length);
    final endIndex = nextIndex == -1
        ? data.indexOf('\n', startIndex + prefix.length)
        : nextIndex;
    if (endIndex == -1)
      return data.substring(startIndex + prefix.length).trim();
    return data.substring(startIndex + prefix.length, endIndex).trim();
  }
}
