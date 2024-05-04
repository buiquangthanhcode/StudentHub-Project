import 'dart:async';

import 'package:flutter/material.dart';
import 'package:studenthub/utils/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({super.key, this.path});

  @override
  // ignore: library_private_types_in_public_api
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
          Page resource error:
            code: ${error.errorCode}
            description: ${error.description}
            errorType: ${error.errorType}
            isForMainFrame: ${error.isForMainFrame}
                    ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {},
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          'https://storage.googleapis.com/20ktpm-studenthub-storage/transcripts/1714409069808-DeThiMauCK_CLC2022.pdf?X-Goog-Algorithm=GOOG4-RSA-SHA256&X-Goog-Credential=studenthub-storage%40fast-lattice-416510.iam.gserviceaccount.com%2F20240429%2Fauto%2Fstorage%2Fgoog4_request&X-Goog-Date=20240429T164435Z&X-Goog-Expires=604800&X-Goog-SignedHeaders=host&X-Goog-Signature=7df4054c0f5a19130e816b46d092bcc6d798fe1cd0d2c9f12f43567459d43513398e0f163209296a03ee972e82fb1c83af8c973e213062a88cb555c44f9dee35e1ef65b65aba41e4f47ba148b827f0286b544fbe9de5ded9b31ad529561821a2a4f22323940e5520b3520d01d3b4fb9cdaa4e52816243b58d10a105b89e7b83ed3228a495bb367ee128a9f0ecdfbca497cde3d9212ca19fefbf204f43750636cd8f0d75c14ec4b1296c62c8f473845b332164dc4e144bdeecf7cf95c717688eca6640c06194d72491406540cdf09bf52a45f97682f4975f8e0520f831341336478baf4bf131a172b2d266c9abeeff9c78965e02fe0eee1ba22e8fb432f9def35'));
    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Document"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
        body: WebViewWidget(
          controller: _controller,
        ));
  }
}
