// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AppWebview extends HookWidget {
  const AppWebview({
    super.key,
    this.url,
    this.htmlText,
    this.redirectUrl,
    this.assetFilePath,
    this.floatingActionButton,
    this.appBarTitle,
    this.showBackButton,
    this.loadingTitle,
    this.loadingDescription,
    this.onUrlRedirection,
  })  : assert(
          url == null || htmlText == null || assetFilePath == null,
          'Cannot use url and html text both',
        ),
        assert(
          url != null || htmlText != null || assetFilePath != null,
          'Url or html text is required',
        );
  final String? url;
  final String? htmlText;
  final String? redirectUrl;
  final String? assetFilePath;
  final Widget? floatingActionButton;
  final Widget? appBarTitle;
  final bool? showBackButton;
  final String? loadingTitle;
  final String? loadingDescription;
  final VoidCallback? onUrlRedirection;

  @override
  Widget build(BuildContext context) {
    final webViewController = useState<InAppWebViewController?>(null);
    final canGoBack = useState<bool>(false);
    final canGoForward = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        centerTitle: false,
        automaticallyImplyLeading: showBackButton ?? true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: canGoBack.value
                ? () {
                    webViewController.value?.goBack();
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: canGoForward.value
                ? () {
                    webViewController.value?.goForward();
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              webViewController.value?.reload();
            },
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: url != null
                ? URLRequest(
                    url: WebUri.uri(Uri.parse(url!)),
                  )
                : null,
            initialData: htmlText != null
                ? InAppWebViewInitialData(data: htmlText!)
                : null,
            initialSettings: InAppWebViewSettings(),
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final url = navigationAction.request.url;
              if (redirectUrl != null) {
                if (url.toString().startsWith(redirectUrl!)) {
                  onUrlRedirection?.call();
                  return NavigationActionPolicy.CANCEL;
                }
              }
              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              canGoBack.value = await controller.canGoBack();
              canGoForward.value = await controller.canGoForward();
            },
            onWebViewCreated: (controller) {
              webViewController.value = controller;
              if (assetFilePath != null) {
                controller.loadFile(assetFilePath: assetFilePath!);
              }
            },
          ),
        ],
      ),
    );
  }
}
