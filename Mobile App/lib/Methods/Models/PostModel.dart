import 'package:firebase_auth/firebase_auth.dart';

class PostModel{
  String id, title, content, imgurl;
  List<String> sender, likes;
  Map<String,List<dynamic>> comments;
  int submittedat, shares;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imgurl,
    required this.sender,
    required this.likes,
    required this.comments,
    required this.submittedat,
    required this.shares,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        id: map["id"],
        title: map["title"],
        content: map["content"],
        imgurl: map["imgurl"],
        sender: List<String>.from(map["sender"]),
        likes: List<String>.from(map["likes"]),
        comments: Map<String,List<dynamic>>.from(map["comments"]),
        submittedat: map['submittedat'],
        shares: map['shares'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content':content,
      'imgurl': imgurl,
      'sender': List<String>.from(sender),
      'likes': List<String>.from(likes),
      'comments': Map<String,List<dynamic>>.from(comments),
      'submittedat': submittedat,
      'shares': shares,
    };
  }

}