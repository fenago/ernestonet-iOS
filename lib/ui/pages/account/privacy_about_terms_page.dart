import 'dart:convert';

import 'package:edustar/core/constants/api_routes.dart';
import 'package:edustar/core/repositories/app_repository.dart';
import 'package:edustar/core/view_models/base_view_model.dart';
import 'package:edustar/ui/pages/base_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extensions/padding_x.dart';
import '../../../core/extensions/theme_x.dart';
import 'package:edustar/core/services/local_storage_service.dart';
import 'package:edustar/core/view_models/privacy_terms_about_view_model.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../locator.dart';

class PrivacyAboutTermsPage extends StatefulWidget {
  final AppDetail appDetail;

  PrivacyAboutTermsPage({
    Key key,
    @required this.appDetail,
  }) : super(key: key);

  @override
  _PrivacyAboutTermsPageState createState() => _PrivacyAboutTermsPageState();
}

class _PrivacyAboutTermsPageState extends State<PrivacyAboutTermsPage> {
  WebViewController _controller;
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAppTitle(widget.appDetail)),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: getURL(widget.appDetail),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        ).paddingVerticalHorizontal(15.0, 10.0),
      ),
    );
  }

  void loadHtml(String htmlData) async {
    _controller.loadUrl(
      Uri.dataFromString(
        htmlData,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }

  String getAppTitle(AppDetail appDetail) {
    switch (appDetail) {
      case AppDetail.terms:
        return 'Terms of Services';
      case AppDetail.privacy:
        return 'Privacy Policy';
      default:
        return 'About';
    }
  }

  String getURL(AppDetail appDetail) {
    switch (appDetail) {
      case AppDetail.terms:
        return ApiRoutes.termsOfServices;
      case AppDetail.privacy:
        return ApiRoutes.privacy;
      default:
        return ApiRoutes.about;
    }
  }
}
