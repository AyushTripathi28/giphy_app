import 'package:flutter/material.dart';
import 'package:giphyapp/models/giphy_model.dart';

//show gifs
class ShowGifView extends StatelessWidget {
  const ShowGifView({super.key, required this.gif});
  final GiphyModel gif;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Image.network(
          fit: BoxFit.cover,
          gif.img,
        ),
      ),
    );
  }
}
