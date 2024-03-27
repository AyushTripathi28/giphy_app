import 'package:flutter/material.dart';
import 'package:giphyapp/providers/giphy_provider.dart';
import 'package:giphyapp/providers/theme_provider.dart';
import 'package:giphyapp/views/components/search_view.dart';
import 'package:giphyapp/views/components/show_gif_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //scroll controller
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //fetchign initial gifs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GiphyProvider>().fetchGifs(isInitial: true);
    });

    //listening to scroll for infinite scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !context.read<GiphyProvider>().isLoading) {
        context.read<GiphyProvider>().fetchGifs(isInitial: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gifProvider = Provider.of<GiphyProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giphy App'),
        actions: [
          Switch(
              inactiveTrackColor: Colors.black,
              activeTrackColor: Colors.white,
              inactiveThumbColor: Colors.white,
              activeColor: Colors.black,
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                value
                    ? themeProvider.toggleTheme(ThemeMode.dark)
                    : themeProvider.toggleTheme(ThemeMode.light);
              }),
        ],
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50), child: SearchView()),
      ),
      body: gifProvider.gifs.isNotEmpty
          ? GridView.builder(
              controller: _scrollController,
              itemCount:
                  gifProvider.gifs.length + (gifProvider.isLoading ? 1 : 0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                if (index == gifProvider.gifs.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ShowGifView(gif: gifProvider.gifs[index]);
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
