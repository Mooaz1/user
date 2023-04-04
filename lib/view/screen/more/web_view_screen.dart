import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;
  WebViewScreen({@required this.url, @required this.title});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController controllerGlobal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    controllerGlobal=WebViewController() ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse(widget.url));

   
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _exitApp,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: [

            CustomAppBar(title: widget.title),

            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(
                  controller: controllerGlobal,
                  ),

                  _isLoading ? CustomLoader(color: Theme.of(context).primaryColor) : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _exitApp() async {
    if(controllerGlobal != null) {
      if (await controllerGlobal.canGoBack()) {
        controllerGlobal.goBack();
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    }else {
      return Future.value(true);
    }
  }
}
