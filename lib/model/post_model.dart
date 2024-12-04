class PostModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  int? markAsRead = 0;

  PostModel({this.userId, this.id, this.title, this.body, this.markAsRead});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      PostModel(userId: json["userId"], id: json["id"], title: json["title"], body: json["body"], markAsRead: json["markAsRead"]);

  Map<String, dynamic> toJson() => {"userId": userId, "id": id, "title": title, "body": body, "markAsRead": markAsRead};
}
