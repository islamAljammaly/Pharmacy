class UserModel {
  String? userId, email, name;

  UserModel({this.userId,this.email,this.name});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    name = json['name'];
  }

  toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
    };
  }
}

