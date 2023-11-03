import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/providers/theme_provider.dart';

final myPageProvider = ChangeNotifierProvider((ref) => MyPageNotifier());

class MyPageNotifier extends ChangeNotifier {}

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => themeNotifier.toggleTheme(),
          child: const Text('Toggle Theme'),
        ),
      ),
    );
  }
}
