class WebtoonDetailModel {
  final String title, genre, age, about;

  WebtoonDetailModel.fromjson(Map<String, dynamic> json)
      : title = json['title'],
        genre = json['genre'],
        age = json['age'],
        about = json['about'];
}
