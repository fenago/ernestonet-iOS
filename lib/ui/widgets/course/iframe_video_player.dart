import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IFrameVideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: WebView(
        initialUrl: Uri.dataFromString(
          '<html><body><iframe width="560" height="315" src="https://www.youtube.com/embed/XsX3ATc3FbA" frameborder="0" allowfullscreen></iframe></body></html>',
          mimeType: 'text/html',
        ).toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
