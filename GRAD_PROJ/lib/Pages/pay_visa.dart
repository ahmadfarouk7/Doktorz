import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaPay extends StatefulWidget {
  final String payUrl;

  const VisaPay({Key? key, required this.payUrl}) : super(key: key);

  @override
  _VisaPayState createState() => _VisaPayState();
}

class _VisaPayState extends State<VisaPay> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.payUrl));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
