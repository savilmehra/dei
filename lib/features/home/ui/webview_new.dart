import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:webview_windows/webview_windows.dart';
import 'package:window_manager/window_manager.dart';


String ci='''<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Getting Started</title>
  </head>
  <body>
    <script
      src="https://code.jquery.com/jquery-3.2.0.min.js"
      integrity="sha256-JAW99MJVpJBGcbzEuXk4Az05s/XyDdBomFqNlM3ic+I="
      crossorigin="anonymous"
    ></script>
    <div id="widget"></div>
    <script src="https://dev-react-18--image-editor-playground.netlify.app/filespin-image-editor.js"></script>

    <script>
const editor = new filespin.ImageEditorInline("widget", {
        src: 'https://picsum.photos/200/300',
        onResult: (result) => {

var dd=encodeURIComponent(result);
        var value = {"url":dd};
  window.chrome.webview.postMessage(value);


        },
        backgrounds: ["https://firebasestorage.googleapis.com/v0/b/allbankifsccode2018new.appspot.com/o/modern-gold-background-free-vector.jpg?alt=media&token=df0131d9-43a1-4672-8193-ea7ac2b54b7e", "https://firebasestorage.googleapis.com/v0/b/allbankifsccode2018new.appspot.com/o/photo-1553095066-5014bc7b7f2d.jpg?alt=media&token=52fd5f78-05fb-4b9f-876d-68dfd307b2a1"],
        watermarks: ["https://firebasestorage.googleapis.com/v0/b/allbankifsccode2018new.appspot.com/o/watermark.png?alt=media&token=d431bbd9-d375-476b-b097-059f3a2d0778"],
        api: {
          baseUrl: 'http://localhost:8000/',
          endpoints: {
            removeBg: 'remove_background/',
            saveResult: 'save/',
          },
        }
      })





    </script>
  </body>
</html>     '''  ;





final navigatorKey = GlobalKey<NavigatorState>();



class ExampleBrowser extends StatefulWidget {
  static String routeName = "/ExampleBrowser";

  static Route<String?> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        return ExampleBrowser();
      },
    );
  }

  @override
  State<ExampleBrowser> createState() => _ExampleBrowser();
}

class _ExampleBrowser extends State<ExampleBrowser> {
  final _controller = WebviewController();
  final _textController = TextEditingController();
  final List<StreamSubscription> _subscriptions = [];
  bool _isWebviewSuspended = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      initPlatformState();
    });

  }

  Future<void> initPlatformState() async {
print("called------------------------------------");
    try {
      await _controller.initialize();
      _subscriptions.add(_controller.url.listen((url) {
        _textController.text = url;
      }));
      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller.loadUrl(Uri.dataFromString(
          ci,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8')
      ).toString());
      _controller.webMessage.listen((event)
      {
        print('receivedddddddddddddddddddddddddddddddddddddddddddd');
        print(event);
        Navigator.pop(context);
      });
      setState(() {});
    } on PlatformException catch (e) {
     print("erooor-------------------------------------${e.toString()}");
    }
  }

  Widget compositeView() {
   return Card(
            color: Colors.transparent,
            elevation: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Webview(
                  _controller,
                  permissionRequested: _onPermissionRequested,
                ),
                _controller.value.isInitialized ?  StreamBuilder<LoadingState>(
                    stream: _controller.loadingState,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data == LoadingState.loading) {
                        return LinearProgressIndicator();
                      } else {
                        return SizedBox();
                      }
                    }):LinearProgressIndicator(),
              ],
            ));



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          title: Text("DEI Edit Image")),
      body: Center(
        child: compositeView(),
      ),
    );
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }

  @override
  void dispose() {
    _subscriptions.forEach((s) => s.cancel());
    super.dispose();
  }
}
