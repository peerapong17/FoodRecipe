import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  RecipeView({required this.postUrl});
  final String postUrl;

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController) {
            setState(
              () {
                _controller.complete(webViewController);
              },
            );
          },
        ),
      ),
    );
  }
}
