class UserModel {
  final String displayName;
  final String avatarUrl;
  final String phoneNumber;
  final String email;
  final String address;
  final int point;
  final List<String> listChatRoom;

  UserModel({
    required this.displayName,
    required this.avatarUrl,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.point,
    required this.listChatRoom,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'],
      avatarUrl: json['avatarUrl'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      address: json['address'],
      point: json['point'] as int,
      listChatRoom: List<String>.from(json['listChatRoom']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'point': point,
      'listChatRoom': listChatRoom,
    };
  }
}
