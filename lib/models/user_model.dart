class UserModel {
  bool success;
  UserData data;

  UserModel({required this.success, required this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    success: json["success"],
    data: UserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data.toJson()};
}

class UserData {
  User user;

  UserData({required this.user});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      UserData(user: User.fromJson(json["user"]));

  Map<String, dynamic> toJson() => {"user": user.toJson()};
}

class User {
  String id;
  String email;
  String firstName;
  String? middleName;
  String lastName;
  String phoneNumber;
  bool isEmailVerified;
  DateTime? resetPasswordOtpExpires;
  DateTime createdAt;

  String get fullName {
    final parts = [
      firstName,
      middleName,
      lastName,
    ].where((p) => p != null && p.trim().isNotEmpty).toList();
    return parts.join(' ');
  }

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.isEmailVerified,
    required this.resetPasswordOtpExpires,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    isEmailVerified: json["isEmailVerified"],
    resetPasswordOtpExpires: json["resetPasswordOTPExpires"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "isEmailVerified": isEmailVerified,
    "resetPasswordOTPExpires": resetPasswordOtpExpires,
    "createdAt": createdAt.toIso8601String(),
  };
}
