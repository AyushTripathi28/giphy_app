import 'package:flutter/material.dart';
import 'package:giphyapp/providers/theme_provider.dart';
import 'package:giphyapp/utils/theme.dart';
import 'package:giphyapp/views/homepage.dart';
import 'package:provider/provider.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: MyAppThemes.lightTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: MyAppThemes.darkTheme,
      home: const HomePage(),
    );
  }
}
