import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key, required this.link, required this.title})
      : super(key: key);

  final String link;
  final String title;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(widget.title),
        //   backgroundColor: Colors.red[900],
        // ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.link,
          ),
        ),
      ),
    );
  }
}
