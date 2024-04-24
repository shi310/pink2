class UserInfo {
  UserInfo({
    required this.userName,
    required this.userId,
    required this.balance,
    required this.isFirstSetPassword,
    this.bank,
    this.usdt,
    this.code,
    this.phone,
  });

  String userName;
  int userId;
  double balance;
  BankInfo? bank;
  BankInfo? usdt;
  String? phone;
  String? code;
  bool isFirstSetPassword;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userName: json["userName"],
        userId: json["userId"],
        balance: json["balance"],
        bank: json["bank"] == null ? null : BankInfo.fromJson(json["bank"]),
        usdt: json["usdt"] == null ? null : BankInfo.fromJson(json["usdt"]),
        phone: json["phone"],
        code: json["code"],
        isFirstSetPassword: json["isFirstSetPassword"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "userId": userId,
        "balance": balance,
        "bank": bank?.toJson(),
        "usdt": usdt?.toJson(),
        "phone": phone,
        "code": code,
        "isFirstSetPassword": isFirstSetPassword,
      };

  static Map<String, dynamic> child = {
    "userName": '',
    "userId": 0,
    "balance": 0.00,
    "isFirstSetPassword": false,
  };
}

class BankInfo {
  BankInfo({
    required this.image,
    required this.number,
    required this.name,
  });

  String image;
  String number;
  String name;

  factory BankInfo.fromJson(Map<String, dynamic> json) => BankInfo(
        image: json["image"],
        number: json["number"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "number": number,
        "name": name,
      };
}
