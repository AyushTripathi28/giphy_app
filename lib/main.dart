import 'package:flutter/material.dart';
import 'package:giphyapp/providers/giphy_provider.dart';
import 'package:giphyapp/providers/theme_provider.dart';
import 'package:giphyapp/root_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => GiphyProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      )
    ], child: const RootApp());
  }
}
