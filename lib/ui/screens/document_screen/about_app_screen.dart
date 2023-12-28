import 'package:caul/ui/components/constants.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width > maxScreenWidth
            ? maxScreenWidth
            : MediaQuery.of(context).size.width,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'おたすけCook！について',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'おたすけCook！では何ができるの？\n',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onBackground,
                          decoration: TextDecoration.none),
                    ),
                    TextSpan(
                      text: '\nおたすけCook！を使うと、選択された食材から料理のレシピを作ることができます。\n'
                          '従来のアプリでは、食材1種類だけでしかレシピを検索できませんが、このアプリを使うと複数の食材を使ったレシピを作成できます！\n'
                          '和食、人数、調理時間なども指定することができます！\n\n',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground,
                          decoration: TextDecoration.none),
                    ),
                    TextSpan(
                      text: '料理を保存できる！\n',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onBackground,
                          decoration: TextDecoration.none),
                    ),
                    TextSpan(
                      text: '\nおたすけCook！にログインしている場合、お気に入りのレシピを保存することができます！\n'
                          '保存ボタンを押せば「保存したレシピ」の部分からいつでも見返すことができます。\n\n',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground,
                          decoration: TextDecoration.none),
                    ),
                    TextSpan(
                      text: '画像からレシピを作れる！？(Comming Soon)\n',
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onBackground,
                          decoration: TextDecoration.none),
                    ),
                    TextSpan(
                      text:
                          '\nレストランで食べた美味しいごはんの写真をアップロードすると、その料理のレシピを作ってくれる機能や、\n'
                          '冷蔵庫の中身を写真に撮るとその食材から料理のレシピを作ってくれる機能を、近々実装予定です！お楽しみに！',
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onBackground,
                          decoration: TextDecoration.none),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
