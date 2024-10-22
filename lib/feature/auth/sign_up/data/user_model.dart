class UserModel {
  String? name;
  String? email;
  String? password;
  String? uId;
  String? image;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.uId,
    this.image,
  });
  UserModel.fromJson(Map<String, dynamic> jason) {
    name = jason['name'];
    email = jason['email'];
    password = jason['password'];
    uId = jason['uId'];
    image = jason['image'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'uId': uId,
      'image': image,
    };
  }
}
