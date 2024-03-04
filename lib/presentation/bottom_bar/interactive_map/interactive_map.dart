import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../bloc/step_pageview/pageview_bloc.dart';
import '../../../constants/strings.dart';

class Interactive_Map extends StatefulWidget {
  @override
  _Interactive_Map createState() => _Interactive_Map();
}

class _Interactive_Map extends State<Interactive_Map> {
  // late ProgressDialog pr;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  // Completer<GoogleMapController> _controller = Completer();
  // late BitmapDescriptor customicon;
  //
  //
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(38.1,35.12),
  //   zoom: 14.4746,
  // );
  //
  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(38.1, 35.12),
  //     tilt: 59.440717697143555,
  //     zoom: 15.151926040649414);
  // List<Marker> _markers = <Marker>[];
  // late final Uint8List markerIcon;

  @override
  void initState() {
    // TODO: implement initState
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    // pr = ProgressDialog(context, showLogs: true);
    // pr.style(message: 'Please wait...');

    super.initState();
  }

  // createMarker(context) async{
  //
  //   // ImageConfiguration configuration = createLocalImageConfiguration(context);
  //   // BitmapDescriptor.fromAssetImage(configuration, 'assets/location.png').then((value) {
  //   //   setState(() {
  //   //     customicon = value;
  //   //     print("----->value icon $value");
  //   //   });
  //   // });
  //
  //
  //    markerIcon = await getBytesFromAsset('assets/location.png', 100);
  //    _markers.add(
  //        Marker(
  //            markerId: MarkerId('SomeId'),
  //            icon: BitmapDescriptor.fromBytes(markerIcon),
  //            position: LatLng(38.123,35.123),
  //            infoWindow: InfoWindow(
  //                title: 'The title of the marker'
  //            )
  //        )
  //    );
  //    _markers.add(
  //        Marker(
  //            markerId: MarkerId('SomeId'),
  //            position: LatLng(38.126,35.129),
  //            icon: BitmapDescriptor.fromBytes(markerIcon),
  //            infoWindow: InfoWindow(
  //                title: 'The title of the marker'
  //            )
  //        )
  //    );
  //
  //
  // }
  //
  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  // }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // createMarker(context);

    // TODO: implement build
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(0, 0));

              return false;
            },
            child: SizedBox(
              width: width,
              height: height,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                key: UniqueKey(),
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onProgress: (int progress) {
                  print('----->WebView is loading (progress : $progress%)');
                  // pr.isShowing();
                },
                initialUrl: URL_MAP,
                javascriptChannels: const <JavascriptChannel>{
                  // _toasterJavascriptChannel(context),
                },
                onPageStarted: (url) {
                  // pr.show();
                },
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
                onPageFinished: (String url) {
                  print("----->onPageFinished : $url");
                  // pr.hide();
                },
                gestureNavigationEnabled: true,
              ),
            )));
  }
}
