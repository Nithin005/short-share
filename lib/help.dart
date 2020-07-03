import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';


class HelpPage extends StatefulWidget {
  HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      
       child:  Scaffold(
      appBar: AppBar(title: Text('Help')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: WebView(
        initialUrl: 'about:blank',
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets();
        },
      ),),
    ),
    );
  }
  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/help.html');
    _controller.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }

}

