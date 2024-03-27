import 'dart:async';

import 'package:flutter/material.dart';
import 'package:giphyapp/models/giphy_model.dart';
import 'package:giphyapp/services/giphy_service.dart';

class GiphyProvider extends ChangeNotifier {
  //list of gifs
  List<GiphyModel> gifs = [];
  //list of gifs for trending
  List<GiphyModel> trendingGifs = [];
  //loading variable
  bool isLoading = false;

  //pagination offset number
  int offsetNumber = 0;

  //timer to serch on the go without any search button
  Timer? _debounce;

  //fetchTrendingGif
  Future<void> fetchGifs({bool isInitial = true}) async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();
    try {
      trendingGifs = await GiphyService.getTrendingGif(offsetNumber);
      if (isInitial) {
        gifs = trendingGifs;
      } else {
        gifs.addAll(trendingGifs);
      }
      offsetNumber += 10;
    } catch (e) {
      print("e: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //fetch searched gif
  Future<void> searchGif(String query) async {
    if (query.isEmpty) {
      gifs = trendingGifs;
      notifyListeners();
      return;
    }

    isLoading = true;

    try {
      gifs = await GiphyService.getSearchedGif(query);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //implementation of search in a particular time duration
  void onSerchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        gifs = trendingGifs;
        notifyListeners();
      } else {
        searchGif(query);
      }
    });
  }
}
