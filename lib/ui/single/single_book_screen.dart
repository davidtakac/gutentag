import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/data/api_service.dart';
import 'package:gutentag/domain/use_case/get_single_book_use_case.dart';
import 'package:gutentag/ui/single/single_book_state.dart';
import 'package:gutentag/ui/single/single_book_view_model.dart';
import 'package:gutentag/ui/webview_screen.dart';

class BookScreen extends StatefulWidget {
  final String bookId;
  const BookScreen({
    required this.bookId,
    super.key
  });

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  late MethodChannel platform;
  late SingleBookViewModel viewModel;

  @override
  void initState() {
    super.initState();
    platform = const MethodChannel('com.example.gutentag/download_manager');
    viewModel = SingleBookViewModel(
        getBookUseCase: GetSingleBookUseCase(
            apiService: ApiService()
        )
    )..getBook(widget.bookId);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.book_title),),
      body: ValueListenableBuilder(
        valueListenable: viewModel.state,
        builder:(context, value, child) {
          return Column(
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: value == null ? 1 : 0,
                child: const LinearProgressIndicator()
              ),
              Expanded(
                child: value == null
                  ? const SizedBox()
                  : _buildScreenContent(context: context, state: value),
              )
            ],
            );
        }
      )
    );
  }

  Widget _buildScreenContent({
    required BuildContext context,
    required SingleBookState state
  }) {
    final items = _buildItems(context: context, state: state);
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
      separatorBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: 32,);
        } else if (index == items.length - 1) {
          return const SizedBox.shrink();
        } else {
          return const SizedBox(height: 8);
        }
      },
    );
  }

  List<Widget> _buildItems({
    required BuildContext context,
    required SingleBookState state,
  }) {
    List<Widget> result = [
      BookHeader(
        coverUrl: state.coverUrl,
        title: state.title,
        authors: state.authors,
        translators: state.translators,
      )
    ];

    final html5Url = state.html5Url;
    if (html5Url != null) {
      result.add(
        FilledButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WebViewScreen(
                  title: state.title,
                  url: html5Url,
                ),
              ),
            );
          },
          child: Text(AppLocalizations.of(context)!.book_btn_read_online),
        )
      );
    }

    final epubUrl = state.epub3Url;
    if (epubUrl != null) {
      result.add(
        OutlinedButton(
          onPressed: () {
            platform.invokeMethod(
              'download',
              {
                'url': epubUrl,
                'name': '${state.title}.epub'
              }
            );
          },
          child: Text(AppLocalizations.of(context)!.book_btn_download_epub)
        )
      );
    }

    final kindleUrl = state.kindleUrl;
    if (kindleUrl != null) {
      result.add(
        OutlinedButton(
          onPressed: () {
            platform.invokeMethod(
              'download',
              {
                'url': kindleUrl,
                'name': '${state.title}.mobi'
              }
            );
          },
          child: Text(AppLocalizations.of(context)!.book_btn_download_kindle)
        )
      );
    }

    final textUrl = state.plainTextUrl;
    if (textUrl != null) {
      result.add(
        OutlinedButton(
          onPressed: () {
            platform.invokeMethod(
              'download',
              {
                'url': textUrl,
                'name': '${state.title}.txt'
              }
            );
          },
          child: Text(AppLocalizations.of(context)!.book_btn_download_txt)
        )
      );
    }

    return result;
  }
}

class BookHeader extends StatelessWidget {
  const BookHeader({
    required this.coverUrl,
    required this.title,
    required this.authors,
    required this.translators,
    super.key,
  });

  final String? coverUrl;
  final String title;
  final String authors;
  final String translators;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            coverUrl ?? '',
            width: 120,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.headlineSmall,),
                Text(authors, style: theme.textTheme.titleMedium,),
                translators.isEmpty 
                  ? Text(AppLocalizations.of(context)!.translators_none)
                  : Text(AppLocalizations.of(context)!.translators_template(translators))
              ],
            ),
          ),
        )
      ],
    );
  }
}