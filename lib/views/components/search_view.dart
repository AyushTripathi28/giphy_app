import 'package:flutter/material.dart';
import 'package:giphyapp/providers/giphy_provider.dart';
import 'package:provider/provider.dart';

//search gif
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    //listener on search change
    _controller.addListener(_onSerchChanged);
  }

  void _onSerchChanged() {
    context.read<GiphyProvider>().onSerchChanged((_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: "Search gif",
        ),
      ),
    );
  }
}
