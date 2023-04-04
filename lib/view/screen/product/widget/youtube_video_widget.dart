import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:webview_flutter/webview_flutter.dart';
class YoutubeVideoWidget extends StatefulWidget {
  final String url;
  YoutubeVideoWidget({@required this.url});

  @override
  State<YoutubeVideoWidget> createState() => _YoutubeVideoWidgetState();
}

class _YoutubeVideoWidgetState extends State<YoutubeVideoWidget> {
  WebViewController webViewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WebViewController() ..setJavaScriptMode(JavaScriptMode.unrestricted)
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
    double width = MediaQuery.of(context).size.width;
    return widget.url.isNotEmpty ?
    Container(height: width/1.55,width:width,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: WebViewWidget(
         controller: webViewController,
        ),) :
    SizedBox.shrink();
  }
}
