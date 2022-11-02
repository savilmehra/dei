import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';

import '../../../universal/uploadfiles/Files/GlobalUploadFilePkg.dart';

class WebViewPage extends StatefulWidget {
  static String routeName = "/webview";

  static Route<String?> route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) {
        return WebViewPage();
      },
    );
  }

  @override
  WebViewPageState createState() => WebViewPageState();
}

String ci = '''<!DOCTYPE html>
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
        src: "https://farm4.staticflickr.com/3075/3168662394_7d7103de7d_z_d.jpg",
        onResult: (result) => {

var dd=encodeURIComponent(result);
        var value = {"url":dd};
  window.chrome.webview.postMessage(value);


        },
        backgrounds: ["https://i.imgur.com/CzXTtJV.jpg"],
        watermarks: ["https://i.imgur.com/OB0y6MR.jpg"],
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
</html>     ''';

final navigatorKey = GlobalKey<NavigatorState>();

class WebViewPageState extends State<WebViewPage> {
  final _controller = WebviewController();
  final _textController = TextEditingController();
  final List<StreamSubscription> _subscriptions = [];
  bool _isWebviewSuspended = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initPlatformState());
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
      _controller.webMessage.listen((event) async {
        print(event);

    /*    final encodedStr = event;
        Uint8List bytes = base64.decode(encodedStr.toString());
        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = File(
            "$dir/${DateTime.now().millisecondsSinceEpoch}.png");
        await file.writeAsBytes(bytes);




        await UploadFile(
          baseUrl: "https://dei-app-sandbox.filespin.io/api/v1/assets/new/content/original/upload",
          context: context,
          networkCallBack: () async {
            // await pr.hide();
          },
          file: file,
        ).uploadFile().then((value) async {}).catchError((onError) async {
          print(onError.toString());
        });*/
      });
      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller.loadUrl(Uri.dataFromString(ci,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString());

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
    return _controller.value.isInitialized
        ? Stack(
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
          )
        : LinearProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Image')),
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
