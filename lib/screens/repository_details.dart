import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RepositoryDetails extends StatefulWidget {
  final String repositoryUrl;
  const RepositoryDetails({required this.repositoryUrl});
  _RepositoryDetailsState createState() => _RepositoryDetailsState();
}

class _RepositoryDetailsState extends State<RepositoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Share.share(widget.repositoryUrl),
              icon: Icon(Icons.share))
        ],
      ),
      body: WebView(
        initialUrl: widget.repositoryUrl,
        gestureNavigationEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }
}
