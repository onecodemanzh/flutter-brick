// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import "package:universal_html/html.dart" as html;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BimApp extends StatefulWidget {
  BimApp({super.key});

  @override
  State<BimApp> createState() => BimAppState();
}

class BimAppState extends State<BimApp> {
  late InAppWebViewController webviewController;
  late WebMessagePort port1;
  late WebMessagePort port2;
  late InAppWebView webView;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    webviewController.dispose();
  }

  /// 向地图发送Json字符串数据
  Future postMessage(dynamic data) async {
    Map<String, String> message = {
      'flutter': jsonEncode(data),
    };
    kIsWeb
        ? await port1.postMessage(WebMessage(data: jsonEncode(message)))
        : await webviewController.evaluateJavascript(
            source: 'getFlutterMessage_app($message)');
    return;
  }

  InAppWebViewSettings settings = InAppWebViewSettings(
    allowFileAccessFromFileURLs: true,
    allowUniversalAccessFromFileURLs: true,
  );
  getWebView(BuildContext context) {
    webView = InAppWebView(
      initialFile: 'assets/bim/index.html',
      initialSettings: settings,
      onWebViewCreated: (ctl) {
        webviewController = ctl;
        ctl.addJavaScriptHandler(
            handlerName: 'handlerMessage',
            callback: (args) {
              /// 接收地图发送到flutter的数据
              // 返回的值，在js端用then接收（暂时直接返回传过来的东西）
              print('Flutter 接收的信息, ${args}');
              return args;
            });
      },
      onReceivedError: (controller, request, error) {},
      onProgressChanged: (controller, progress) {},
      onLoadStop: (controller, url) async {},
      onConsoleMessage: (controller, consoleMessage) {
        print("onConsoleMessage: ${consoleMessage.message}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getWebView(context);
    return Container(width: 400, height: 600, child: webView);
  }
}
