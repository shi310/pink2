class NoticeList {
  NoticeList({
    required this.noticeList,
    required this.size,
  });

  final List<NoticeData> noticeList;
  final int size;

  factory NoticeList.fromJson(Map<String, dynamic> json) => NoticeList(
        noticeList: List<NoticeData>.from(
            json["noticeList"].map((x) => NoticeData.fromJson(x))),
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "noticeList": List<dynamic>.from(noticeList.map((x) => x.toJson())),
        "size": size,
      };
  static Map<String, dynamic> child = {
    "noticeList": <NoticeData>[],
    "size": 0,
  };
}

class NoticeData {
  NoticeData({
    required this.content,
    required this.id,
    required this.timer,
    required this.title,
  });

  final String content;
  final int id;
  final String timer;
  final String title;

  factory NoticeData.fromJson(Map<String, dynamic> json) => NoticeData(
        content: json["content"],
        id: json["id"],
        timer: json["timer"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "id": id,
        "timer": timer,
        "title": title,
      };
}
