import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final selectedVegetablesProvider = StateProvider<List<String>>((ref) {
  return [];
});
