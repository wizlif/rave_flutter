import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:rave_flutter/src/models/momo_response.dart';

class OTPRedirect extends StatefulWidget {
  final MoMoResponse moMoResponse;
  final Function(Map) onPaymentComplete;
  final String redirectURL;
  final Function(FlutterWebviewPlugin) webViewPlugin;

  const OTPRedirect({Key key, this.moMoResponse, this.onPaymentComplete, this.webViewPlugin, this.redirectURL}) : super(key: key);

  @override
  _OTPRedirectState createState() => _OTPRedirectState();
}

class _OTPRedirectState extends State<OTPRedirect> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int pop = 0;

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onUrlChanged.listen(_handleLoad);

    if(widget.webViewPlugin != null) widget.webViewPlugin(flutterWebViewPlugin);
  }

  void _handleLoad(String value) {
    if (value.contains(widget.redirectURL)) {
      Uri uri = Uri.parse(Uri.decodeComponent(value));
      Map parameters = jsonDecode(uri.queryParameters["resp"]);

      if(parameters.containsKey("status") && parameters["status"] == "success") {
        widget.onPaymentComplete(parameters);
      }else{
        //TODO: Handle failed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: _scaffoldKey,
      url: "${widget.moMoResponse.meta.authorization.redirect}",
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
