import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullScreenWebView extends StatelessWidget {
  FullScreenWebView(this.url, {Key? key}) : super(key: key);

  final String url;

  late final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..loadRequest(Uri.parse(url));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
