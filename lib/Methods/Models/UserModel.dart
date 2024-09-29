class UserModel{

  String id, fname, lname, email, imgurl;
  int points;

  UserModel({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.points,
    required this.imgurl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["uid"],
      fname: map["fname"],
      lname: map["lname"],
      email: map["email"],
      imgurl: map["imgurl"],
      points: map["points"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": id,
      "fname": fname,
      "lname": lname,
      "email": email,
      "points": points,
      "imgurl": imgurl,
    };
  }
}

