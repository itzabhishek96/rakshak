import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class SafeWebView extends StatelessWidget {
  final String url;
  SafeWebView({required this.url});
  
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
    );
  }
}
