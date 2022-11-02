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

var srcUrl='';





 const editor = new filespin.ImageEditorInline("widget", {
        src: 'https://picsum.photos/200/300',
        onResult: (result) => {

var dd=encodeURIComponent(result);
        var value = {"url":dd};
  window.chrome.webview.postMessage(value);


        },
        backgrounds: ["https://picsum.photos/id/237/200/300", "https://picsum.photos/200/300?grayscale"],
        watermarks: ["https://picsum.photos/200/300/?blur", "https://picsum.photos/200/300.jpg"],
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

class WebViewPageN extends StatefulWidget {
  static String routeName = "/webview";

  static Route<String?> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        return WebViewPageN();
      },
    );
  }

  @override
  WebViewPageNState createState() => WebViewPageNState();
}

class WebViewPageNState extends State<WebViewPageN> {
  final _controller = WebviewController();
  final _textController = TextEditingController();
  final List<StreamSubscription> _subscriptions = [];
  bool _isWebviewSuspended = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Optionally initialize the webview environment using
    // a custom user data directory
    // and/or a custom browser executable directory
    // and/or custom chromium command line flags
    //await WebviewController.initializeEnvironment(
    //    additionalArguments: '--show-fps-counter');

    try {
      await _controller.initialize();
      _subscriptions.add(_controller.url.listen((url) {
        _textController.text = url;
      }));

      String fileText = await rootBundle.loadString('lib/assets/index.html');

      _controller.webMessage.listen((event)

      {
        print('receivedddddddddddddddddddddddddddddddddddddddddddd');
        print(event);
      });
      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller.loadUrl(Uri.dataFromString(
          ci,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8')
      ).toString());

      var json = '{"name":"John", "age":30, "car":null}';
      // SENT DATA TO HTML CONTENT
      _controller.postWebMessage(json);

      setState(() {});
    } on PlatformException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Code: ${e.code}'),
                  Text('Message: ${e.message}'),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Continue'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
      });
    }
  }

  Widget compositeView() {
    if (!_controller.value.isInitialized) {
      return const Text(
        'Not Initialized',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 0,
              child: Row(children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'URL',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    controller: _textController,
                    onSubmitted: (val) {
                      _controller.loadUrl(val);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  splashRadius: 20,
                  onPressed: () {
                    _controller.reload();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.developer_mode),
                  tooltip: 'Open DevTools',
                  splashRadius: 20,
                  onPressed: () {
                    _controller.openDevTools();
                  },
                )
              ]),
            ),
            Expanded(
                child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        Webview(
                          _controller,
                          permissionRequested: _onPermissionRequested,
                        ),
                        StreamBuilder<LoadingState>(
                            stream: _controller.loadingState,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data == LoadingState.loading) {
                                return LinearProgressIndicator();
                              } else {
                                return SizedBox();
                              }
                            }),
                      ],
                    ))),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: _isWebviewSuspended ? 'Resume webview' : 'Suspend webview',
        onPressed: () async {
          if (_isWebviewSuspended) {
            await _controller.resume();
          } else {
            await _controller.suspend();
          }
          setState(() {
            _isWebviewSuspended = !_isWebviewSuspended;
          });
        },
        child: Icon(_isWebviewSuspended ? Icons.play_arrow : Icons.pause),
      ),
      appBar: AppBar(
          title: StreamBuilder<String>(
            stream: _controller.title,
            builder: (context, snapshot) {
              return Text(
                  snapshot.hasData ? snapshot.data! : 'WebView (Windows) Example');
            },
          )),
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