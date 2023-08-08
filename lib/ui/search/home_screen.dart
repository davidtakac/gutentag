import 'package:flutter/material.dart';
import 'package:gutentag/di/injection.dart';
import 'package:gutentag/ui/common/book_card_state.dart';
import 'package:gutentag/ui/search/search_view_model.dart';
import 'package:gutentag/ui/common/book_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gutentag/ui/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SearchViewModel viewModel;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    viewModel = getIt()..loadNextPage();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
          viewModel.loadNextPage();
        }
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.home_title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder:(context) {
                  return const BookSearchScreen();
                },)
              );
            }, 
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: viewModel.results,
            builder: (BuildContext context, List<BookCardState>? value, Widget? child) {
              return ListView(
                  controller: scrollController,
                  children: [
                    ...value?.map((e) => Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: BookCard(cardState: e),
                    )).toList() ?? [],
                    const SizedBox(height: 16,)
                  ],
              );
            }
          ),
          Center(
            child: ValueListenableBuilder(
              valueListenable: viewModel.isLoading, 
              builder:(context, value, child) => value ? const CircularProgressIndicator() : Container(),
            ),
          ),
        ],
      ),
    );
  }
}