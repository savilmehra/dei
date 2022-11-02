import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart';
import 'dart:convert';
import '../../../universal/uploadfiles/Files/GlobalUploadFilePkg.dart';
import '../fielSpinResponse.dart';

class WebViewPage extends StatefulWidget {
  static String routeName = "/webview";

  final String url;
  final Function(String) updateCallBack;

  const WebViewPage(
      {super.key, required this.url, required this.updateCallBack});

  @override
  WebViewPageState createState() => WebViewPageState();
}

String gertHtml(url) {
  return '''<!DOCTYPE html>
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
        src: '$url',
        onResult: (result) => {

var dd=encodeURIComponent(result);
        var value = {"url":result};
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
}

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
        final uri = Uri.parse(event['url']);

        final splitted =
            event['url'].toString().split('data:image/jpeg;base64,');

        Uint8List bytes = base64.decode(splitted[1]);
        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.jpeg");
        await file.writeAsBytes(bytes);

        print(file.absolute);

        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'https://dei-app-sandbox.filespin.io/api/v1/assets/new/content/original/upload'));

        request.headers
            .addAll({"X-FileSpin-Api-Key": "852c3af777b3481eb6b22a0e99d15c6c"});

        request.files
            .add(await http.MultipartFile.fromPath("file=@", file.path));

        var response = await request.send();

        var responsed = await http.Response.fromStream(response);
        final fileSpinData = FileSpinResponse.fromJson(jsonDecode(responsed.body));
         widget.updateCallBack(fileSpinData.files![0].thumbnail??"");
         Navigator.pop(context);
        if (fileSpinData != null && fileSpinData.success) {
          print("SUCCESS");
        } else {
          print("ERROR");
        }
      });
      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller.loadUrl(Uri.dataFromString(gertHtml(widget.url),
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
