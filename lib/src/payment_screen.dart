import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class PaymentScreen extends StatefulWidget {
  final String request;
  final String returnUrl;

  PaymentScreen(this.request, this.returnUrl);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              if (url == widget.returnUrl) {
                readJS(context);
              }
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadHtmlString(widget.request);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            WebViewWidget(controller: _controller),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void readJS(BuildContext cont) async {
    String html = await _controller.runJavaScript(
        "window.document.getElementsByTagName('pre')[0].innerHTML;") as String;

    try {
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(cont, html);
    } catch (err) {
      debugPrint('Exception: $err');
      Navigator.pop(cont, null);
    }
  }
}
