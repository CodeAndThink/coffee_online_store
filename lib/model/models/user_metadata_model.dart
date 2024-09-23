import 'package:coffee_online_store/model/models/user_model.dart';

class UserMetadataModel {
  final String userDocId;
  final UserModel userData;

  UserMetadataModel({required this.userDocId, required this.userData});

  Map<String, dynamic> toJson() {
    return {
      'userDocId': userDocId,
      'userData': userData.toJson(),
    };
  }

  factory UserMetadataModel.fromJson(Map<String, dynamic> json) {
    return UserMetadataModel(
      userDocId: json['userDocId'],
      userData: UserModel.fromJson(json['userData']),
    );
  }

  @override
  String toString() {
    return 'UserMetadataModel(userDocId: $userDocId, userData: $userData)';
  }
}
