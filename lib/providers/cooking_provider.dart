import 'package:flutter_riverpod/flutter_riverpod.dart';

// selectedHeadersの状態を管理するプロバイダを定義します
final selectedHeadersProvider = StateProvider<Map<String, Set<String>>>((ref) {
  return {
    "調理時間": {},
    "人数": {},
    "タイプ": {},
    "量": {},
    "その他の条件": {},
    "選んだ食材以外を材料に含めてもよい": {},
  };
});

// selectedVegetablesの状態を管理するプロバイダを定義します
final selectedVegetablesProvider = StateProvider<List<String>>((ref) {
  return [];
});
