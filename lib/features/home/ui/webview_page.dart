import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

class WebViewPageState extends State<WebViewPage> {
  late WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () async {
                  await Future.delayed(Duration(seconds: 1));

                  webViewController
                      .runJavascriptReturningResult("document.forms[0].submit()");
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.blue,
                )),
            IconButton(
                onPressed: () {
                  const yser = "IN-P938";
                  const companyName = "BORN";
                  const password = "Kashyap.90";

                  webViewController.runJavascriptReturningResult(
                      "document.getElementById('userId').value='$yser'");
                  webViewController.runJavascriptReturningResult(
                      "document.getElementById('companyName').value='$companyName'");
                  webViewController.runJavascriptReturningResult(
                      "document.getElementById('j_password').value='$password'");




                },
                icon: const Icon(
                  Icons.hail_rounded,
                  color: Colors.blue,
                ))
          ],
          title: Text(
            "Hi Note ",
            style: TextStyle(color: Colors.blueAccent),
          )),
      body: WebView(
        onWebViewCreated: (con) {
          this.webViewController = con;
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://hinote.in/hrworksidp/secure.jsp",
      ),
    );
  }
}
