import 'package:caul/ui/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  Future<String> loadPrivacyPolicy() async {
    return await rootBundle.loadString('assets/terms_and_conditions.md');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width > maxScreenWidth
            ? maxScreenWidth
            : MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('利用規約'),
          ),
          body: FutureBuilder(
            future: loadPrivacyPolicy(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(child: Text('エラーが発生しました。'));
                }

                return Markdown(
                  data: snapshot.data!,
                  padding: const EdgeInsets.all(32),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
