import 'dart:async';
import 'dart:collection';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../constants/strings.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/my_colors.dart';
import 'CustomLoading.dart';

class WebViewPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final link;
  // ignore: use_key_in_widget_constructors
  const WebViewPage(this.link);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool error = false;
  bool isLoading = true;
  late String token;
  void getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString(ACCESS_TOKEN)!;
    });
  }

  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        //Color.fromRGBO(255, 230, 225, 1),
        padding: EdgeInsets.only(top: 40),
        child: Stack(
          children: [
            // WebView(
            //   onPageFinished: (_) {
            //     setState(() {
            //       isLoading = false;
            //     });
            //   },
            //   onWebResourceError: (error) {
            //     this.error = true;
            //   },
            //   initialUrl: widget.link,
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onWebViewCreated: (controller) {
            //     Map<String, String> headers = {
            //       "Authorization": "Bearer " + token
            //     };
            //     controller.loadUrl(widget.link, headers: headers);
            //     _controller.complete(controller);
            //   },
            // ),
            InAppWebView(
              initialUrlRequest: URLRequest(url: widget.link),
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              onWebViewCreated: (myController) async {
                webViewController = myController;
              },
              initialOptions: options,
              onLoadError: (ctrl, url, code, message) {
                this.error = true;
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final uri = navigationAction.request.url!;
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStart: (webViewController, uri) {},
              onLoadStop: (ctrl, url) async {
                setState(() {
                  isLoading = false;
                });
              },
            ),

            isLoading ? Center(child: CustomLoading()) : Container(),
            error ? Text("تأكد من الاتصال بالانترنت ") : Container(),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.arrow_forward,
                        size: 25,
                      ),
                    ],
                  ),
                  backgroundColor: HexColor(MyColors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
    );
  }

  Widget kTextbody(String message, {double size = 14, TextAlign align = TextAlign.center, double paddingV = 4, double paddingH = 4, bool bold = false, int? maxLines, bool white = false, Color color = Colors.black87}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
      child: Text(
        message,
        style: TextStyle(
          color: white ? Colors.white : color,
          fontSize: size,
          fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
        ),
        textAlign: align,
        maxLines: maxLines,
        overflow: maxLines == null ? null : TextOverflow.ellipsis,
      ),
    );
  }
}
