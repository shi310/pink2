// 返回数据格式化
class ResponseData {
  ResponseData({
    required this.code,
    required this.data,
    required this.msg,
  });

  int code;
  Map<String, dynamic> data;
  String msg;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        code: json["code"],
        data: json["data"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data,
        "msg": msg,
      };
}

class SearchWordData {
  SearchWordData({
    required this.searchWord,
  });

  String searchWord;

  factory SearchWordData.fromJson(Map<String, dynamic> json) => SearchWordData(
        searchWord: json["searchWord"],
      );

  Map<String, dynamic> toJson() => {"searchWord": searchWord};
}
