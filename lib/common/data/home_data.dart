import 'package:pinker/common/data/library.dart';

class HomeData {
  HomeData({
    required this.banner,
    required this.medias,
  });

  List<HomeDataBanner> banner;
  List<HomeDataMedias> medias;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        banner: List<HomeDataBanner>.from(
            json["banner"].map((x) => HomeDataBanner.fromJson(x))),
        medias: List<HomeDataMedias>.from(
            json["medias"].map((x) => HomeDataMedias.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
        "medias": List<dynamic>.from(medias.map((x) => x.toJson())),
      };

  static Map<String, dynamic> child = {
    "banner": <HomeDataBanner>[],
    "medias": <HomeDataMedias>[],
  };
}

class HomeDataBanner {
  HomeDataBanner({
    required this.image,
    required this.title,
    this.bannerUrl,
  });

  String image;
  String title;
  String? bannerUrl;

  factory HomeDataBanner.fromJson(Map<String, dynamic> json) => HomeDataBanner(
        image: json["image"],
        title: json["title"],
        bannerUrl: json["bannerUrl"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "bannerUrl": bannerUrl,
      };
}

class HomeDataMedias {
  HomeDataMedias({
    required this.list,
    required this.title,
  });

  List<ResourceData> list;
  String title;

  factory HomeDataMedias.fromJson(Map<String, dynamic> json) => HomeDataMedias(
        list: List<ResourceData>.from(
            json["list"].map((x) => ResourceData.fromJson(x))),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "title": title,
      };
}
