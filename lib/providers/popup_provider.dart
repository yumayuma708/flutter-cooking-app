import 'package:caul/status/popup.state.dart';
import 'package:caul/ui/screens/cooking_screen/choose_ingredients_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popupProvider = StateNotifierProvider<PopupNotifier, PopupState>((ref) {
  return PopupNotifier();
});
