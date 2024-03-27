import 'dart:convert';

import 'package:giphyapp/models/giphy_model.dart';
import 'package:http/http.dart' as http;

const API_KEY = "AzC9zDatpCp2biBL7I66TPoxCl2UYei8";

class GiphyService {
  //get trending
  static Future<List<GiphyModel>> getTrendingGif(int offset) async {
    var response = await http.get(Uri.parse(
        "https://api.giphy.com/v1/gifs/trending?api_key=$API_KEY&offset=$offset&limit=10"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return (json["data"] as List).map((e) => GiphyModel.fromJson(e)).toList();
    } else if (response.statusCode == 429) {
      throw Exception('Rate limit exceed');
    } else {
      throw Exception('Failed to fetch gifs');
    }
  }

  //get search
  static Future<List<GiphyModel>> getSearchedGif(String query) async {
    var response = await http.get(Uri.parse(
        "https://api.giphy.com/v1/gifs/search?api_key=$API_KEY&q=$query"));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json["data"] as List).map((e) => GiphyModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch gifs');
    }
  }
}
