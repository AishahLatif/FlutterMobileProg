import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart';
import '../models/usermodel.dart';

class PaymentScreen extends StatefulWidget {
  final double totalpayable;
  final User user;
  const PaymentScreen({ Key? key, required this.totalpayable, required this.user }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Column(
        children: <Widget>[
        Expanded(
          child: WebView(
          initialUrl: CONSTANTS.server +
          '/mytutor/mobile/php/payment.php?email=' +
          widget.user.email.toString() +
          '&mobile=' +
          widget.user.phoneno.toString() +
          '&name=' +
          widget.user.name.toString() +
          '&amount=' +
          widget.totalpayable.toString(),
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },

        ) ,)
      ],)
    );
  }
}