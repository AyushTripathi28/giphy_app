//Gif model
class GiphyModel {
  final String id;
  final String title;
  final String img;

  GiphyModel({
    required this.id,
    required this.title,
    required this.img,
  });

  factory GiphyModel.fromJson(Map<String, dynamic> json) {
    return GiphyModel(
        id: json['id'],
        title: json['title'],
        img: json['images']['preview_gif']["url"]);
  }
}
