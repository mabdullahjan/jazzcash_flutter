import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  final String request;
  final String returnUrl;
  PaymentScreen(this.request, this.returnUrl);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late WebViewController controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true;
            _hasError = false;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _isLoading = false;
            debugPrint('debugPrint Page finished loading: $url');
            if (url == widget.returnUrl) {
              readJS(context);
            }
          });
        },
        onWebResourceError: (WebResourceError error) {
          setState(() {
            _isLoading = false;
            _hasError = true;
          });
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith(widget.request)) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.request));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (_hasError)
              const Center(
                child: Text(
                  'Failed to load payment page.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void readJS(BuildContext cont) async {
    Object html = await controller!.runJavaScriptReturningResult(
        "window.document.getElementsByTagName('pre')[0].innerHTML;");

    try {
      // var jsondecoded = json.decode(html);
      // PaymentResponseModel paymentResponseModel;
      // if (Platform.isIOS) {
      //   // ios
      //   paymentResponseModel = PaymentResponseModel.fromJson(jsondecoded);
      // } else if (Platform.isAndroid) {
      //   // android
      //   paymentResponseModel =
      //       PaymentResponseModel.fromJson(json.decode(jsondecoded));
      // }
      // log('jsondecoded --> ${jsondecoded}');
      await Future.delayed(Duration(seconds: 2));
      // Navigator.pop(cont, paymentResponseModel);
      Navigator.pop(cont, html);
      // if(jsondecoded['pp_ResponseCode']=='000'){
      //
      // }
    } catch (err) {
      debugPrint('debugPrint exception $err');
      Navigator.pop(cont, null);
    }
    // print("html response --> $html");
  }
}
