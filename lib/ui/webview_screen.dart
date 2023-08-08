import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({
    required this.title,
    required this.url,
    super.key
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController webViewController;
  final ValueNotifier<double> _progress = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            _progress.value = progress.toDouble() / 100;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            ValueListenableBuilder(
                valueListenable: _progress,
                builder: (_, value, __) {
                  return AnimatedOpacity(
                    opacity: value >= 1 ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: _AnimatedLinearProgressIndicator(progress: value)
                  );
                }
            ),
            Expanded(child: WebViewWidget(controller: webViewController)),
          ],
        ),
      )
    );
  }
}

class _AnimatedLinearProgressIndicator extends StatelessWidget {
  const _AnimatedLinearProgressIndicator({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: progress),
      builder: (_, double value, __) => LinearProgressIndicator(value: value,)
    );
  }
}