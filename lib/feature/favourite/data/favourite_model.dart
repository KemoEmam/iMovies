class FavouriteModel {
  String? id;
  String? title;
  String? decription;
  String? image;
  String? overview;


  FavouriteModel({
    this.id,
    this.title,
    this.decription,
    this.image,
    this.overview,
  });
  FavouriteModel.fromJson(Map<String, dynamic> jason) {
    id = jason['id'];
    title = jason['title'];
    decription = jason['decription'];
    image = jason['image'];
    overview = jason['overview'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'decription': decription,
      'image': image,
      'overview': overview,
    };
  }
}
