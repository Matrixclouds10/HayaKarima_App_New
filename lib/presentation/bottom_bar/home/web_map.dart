import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hayaah_karimuh/constants/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewMap extends StatefulWidget {
   const WebviewMap();

  @override
  State<WebviewMap> createState() => _WebviewMapState();
}

class _WebviewMapState extends State<WebviewMap> {
  bool webIsLoading = true;
  // final Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        if (webIsLoading) const Center(child: CircularProgressIndicator()),
        Container(
          width: width,
          height: height,
          margin: EdgeInsets.only(top: 15.h, right: 10.w, left: 10.w, bottom: 10.h),
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              // _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              print('----->WebView is loading (progress : $progress%)');
              // pr.isShowing();
            },
            initialUrl: URL_MAP,
            javascriptChannels: const <JavascriptChannel>{
              // _toasterJavascriptChannel(context),
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) {
              print("----->onPageFinished : $url");
              webIsLoading = false;
              setState(() {});
              // // pr.hide();
            },
            gestureNavigationEnabled: false,
          ),
        ),
      ],
    );
  }
}
