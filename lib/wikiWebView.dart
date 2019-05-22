//import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';
//
//class PuppyWikiWebview extends StatefulWidget {
//  @override
//  createState() => new PuppyWikiWebviewState();
//}
//
//class PuppyWikiWebviewState extends State<PuppyWikiWebview> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Here's some facts"),
//      ),
//      body: Builder(builder: (BuildContext context) {
//        return WebView(
//          initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
//          javascriptMode: JavascriptMode.unrestricted,
//          onPageFinished: (String url) {
//            print('Page finished loading: $url');
//          },
//        );
//      }),
//    );
//  }
//}
