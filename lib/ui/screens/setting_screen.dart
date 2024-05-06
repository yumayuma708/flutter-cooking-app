import 'package:caul/providers/theme_provider.dart';
import 'package:caul/ui/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider);

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width > maxScreenWidth
            ? maxScreenWidth
            : MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('設定'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () => themeNotifier.toggleTheme(),
              child: const Text('ダークモードとライトモードを切り替える'),
            ),
          ),
        ),
      ),
    );
  }
}
