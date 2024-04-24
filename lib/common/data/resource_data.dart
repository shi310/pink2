class ResourceData {
  ResourceData({
    required this.name,
    required this.image,
    required this.playUrls,
    required this.id,
    required this.isCanSee,
    required this.payType,
    this.introduction,
    this.introduce,
    this.score,
    this.ranking,
    this.year,
    this.country,
    this.typeName,
    this.mediaType,
    this.actors,
    this.director,
    this.pubTime,
    this.price,
    this.shortUrl,
  });

  /// 影片的名字
  String name;

  /// 影片的图片地址
  String image;

  /// 影片的简单介绍，一般用于一行展示
  String? introduction;

  /// 影片的详细介绍，一般是多行展示
  String? introduce;

  /// 影片的评分
  double? score;

  /// 影片的类目排名
  int? ranking;

  /// 影片的年份
  String? year;

  /// 硬派呢的国家：中国大陆，欧美，日韩
  String? country;

  /// 影片的类型：电影，电视剧，综艺，动漫，午夜剧场
  String? typeName;

  /// 影片的子类型：比如电影里的正在热映，欧美，大陆，等
  String? mediaType;

  /// 影片的演员表
  String? actors;

  /// 影片的导演
  String? director;

  /// 播放地址
  List<PlayUrls> playUrls;

  /// id
  int id;

  /// 发布时间
  int? pubTime;

  /// 是否能观看
  bool isCanSee;

  /// 资源的价格
  int? price;

  /// 收费方式
  int payType;

  /// 短视频播放地址
  String? shortUrl;

  factory ResourceData.fromJson(Map<String, dynamic> json) => ResourceData(
        name: json['name'],
        image: json['image'],
        introduction: json['introduction'],
        introduce: json['introduce'],
        score: json['score'],
        ranking: json['ranking'],
        year: json['year'],
        country: json['country'],
        typeName: json['typeName'],
        mediaType: json['mediaType'],
        actors: json['actors'],
        director: json['director'],
        playUrls: List<PlayUrls>.from(
            json["playUrls"].map((x) => PlayUrls.fromJson(x))),
        id: json['id'],
        pubTime: json['pubTime'],
        isCanSee: json['isCanSee'],
        price: json['price'],
        payType: json['payType'],
        shortUrl: json['shortUrl'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'introduction': introduction,
        'introduce': introduce,
        'score': score,
        'ranking': ranking,
        'year': year,
        'country': country,
        'typeName': typeName,
        'mediaType': mediaType,
        'actors': actors,
        'director': director,
        'playUrls': List<dynamic>.from(playUrls.map((x) => x.toJson())),
        'id': id,
        'pubTime': pubTime,
        'isCanSee': isCanSee,
        'price': price,
        'payType': payType,
        'shortUrl': shortUrl,
      };
  static Map<String, dynamic> child = {
    'name': '',
    'image': '',
    'playUrls': <PlayUrls>[],
    'isCanSee': true,
    'id': 0,
    'payType': 0,
  };
}

class ResourceDataList {
  ResourceDataList({
    required this.list,
    required this.size,
  });

  List<ResourceData> list;
  int size;

  factory ResourceDataList.fromJson(Map<String, dynamic> json) =>
      ResourceDataList(
        list: List<ResourceData>.from(
            json["list"].map((x) => ResourceData.fromJson(x))),
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "size": size,
      };

  static Map<String, dynamic> child = {
    "list": <ResourceDataList>[],
    "size": 0,
  };
}

class MediaTypeList {
  MediaTypeList({
    required this.list,
    required this.size,
  });

  List<MediaType> list;
  int size;

  factory MediaTypeList.fromJson(Map<String, dynamic> json) => MediaTypeList(
        list: List<MediaType>.from(
            json["list"].map((x) => MediaType.fromJson(x))),
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "size": size,
      };
  static Map<String, dynamic> child = {
    "list": <MediaType>[],
    "size": 0,
  };
}

class MediaType {
  MediaType({
    required this.mediaTypeId,
    required this.mediaTypeName,
    required this.typelist,
  });

  String mediaTypeId;
  String mediaTypeName;
  List<String> typelist;

  factory MediaType.fromJson(Map<String, dynamic> json) => MediaType(
        mediaTypeId: json["mediaTypeId"],
        mediaTypeName: json["mediaTypeName"],
        typelist: List<String>.from(json["typelist"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "mediaTypeId": mediaTypeId,
        "mediaTypeName": mediaTypeName,
        "typelist": List<dynamic>.from(typelist.map((x) => x)),
      };
}

class TypeList {
  TypeList({
    required this.list,
    required this.size,
  });

  List<String> list;
  int size;

  factory TypeList.fromJson(Map<String, dynamic> json) => TypeList(
        list: List<String>.from(json["list"].map((x) => x)),
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<String>.from(list.map((x) => x)),
        "size": size,
      };

  static Map<String, dynamic> child = {"size": 0, "list": <String>[]};
}

class ResourceResponseData {
  ResourceResponseData({
    required this.type,
    this.year,
    this.country,
    this.keyword,
    this.mediaType,
    this.pageNo,
    this.pageSize,
    this.sort,
  });

  int type;
  int? mediaType;
  int? pageNo;
  int? pageSize;
  int? country;
  String? keyword;
  int? year;
  int? sort;

  factory ResourceResponseData.fromJson(Map<String, dynamic> json) =>
      ResourceResponseData(
        type: json['type'],
        mediaType: json['mediaType'],
        pageNo: json['pageNo'],
        pageSize: json['pageSize'],
        country: json['country'],
        keyword: json['keyword'],
        year: json['year'],
        sort: json['sort'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'mediaType': mediaType,
        'pageNo': pageNo,
        'pageSize': pageSize,
        'country': country,
        'keyword': keyword,
        'year': year,
        'sort': sort,
      };

  static Map<String, dynamic> child = {'type': 0};
}

class PlayUrls {
  PlayUrls({
    required this.title,
    required this.urls,
  });

  String title;
  List<String> urls;

  factory PlayUrls.fromJson(Map<String, dynamic> json) => PlayUrls(
        title: json['title'],
        urls: List<String>.from(json["urls"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "urls": List<String>.from(urls.map((x) => x)),
      };
}
