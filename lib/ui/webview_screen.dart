import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String title;
  final String url;
  final ValueNotifier<double> _progress = ValueNotifier(0.0);

  WebViewScreen({
    required this.title,
    required this.url,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webViewController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            _progress.value = progress.toDouble() / 100;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(title: Text(title),),
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