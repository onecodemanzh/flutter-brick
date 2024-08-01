// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:universal_html/html.dart" as html;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:convert';
import 'map.dart';

class MapWeb extends StatefulWidget {
  MapWeb({super.key});

  @override
  State<MapWeb> createState() => MapWebState();
}

class MapWebState extends State<MapWeb> {
  late InAppWebViewController webviewController;

  late InAppWebView webView;
  @override
  void initState() {
    super.initState();
    html.window.addEventListener('message', listen, true);
  }

  @override
  void dispose() {
    super.dispose();
    webviewController.dispose();
  }

  void listen(html.Event event) {
    var str = (event as dynamic).data;
    if (str.runtimeType == String) {
      var data = jsonDecode(str);

      if (data is Map) {
        if (data['flutter'] == null) {
          print(jsonEncode(data));
        }
      }
    }
  }

  /// 向地图发送Json字符串数据
  Future postMessage(MapMessage data) async {
    Map<String, String> message = {
      'flutter': jsonEncode({'fn': data.fn.toString(), 'data': data.data}),
    };
    dynamic origin = html.window.location.origin;
    html.window.postMessage(jsonEncode(message), origin);
    return;
  }

  InAppWebViewSettings settings = InAppWebViewSettings(
    allowsInlineMediaPlayback: true,
    javaScriptEnabled: true,
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
  );
  getWebView(BuildContext context) {
    webView = InAppWebView(
      initialFile: 'assets/map/index.html',
      initialSettings: settings,
      onWebViewCreated: (ctl) {
        webviewController = ctl;
      },
      onReceivedError: (controller, request, error) {},
      onProgressChanged: (controller, progress) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    getWebView(context);
    return Container(
      width: double.infinity,
      height: 600,
      child: webView,
    );
  }
}
