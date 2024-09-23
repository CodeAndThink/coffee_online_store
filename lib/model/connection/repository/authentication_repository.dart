import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_online_store/model/models/user_metadata_model.dart';
import 'package:coffee_online_store/model/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  AuthenticationRepository(this._firebaseAuth, this._firebaseFirestore);

  Future<UserMetadataModel?> getUserData(String uid) async {
    final userDoc = await _firebaseFirestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      final userData = UserModel.fromJson(userDoc.data()!);
      final userMetadata =
          UserMetadataModel(userDocId: uid, userData: userData);
      return userMetadata;
    } else {
      return null;
    }
  }

  //Save userdata to local
  Future<void> saveUserProfile(UserMetadataModel userMetadata) async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = jsonEncode(userMetadata.toJson());
    await prefs.setString('userData', userDataJson);
  }

  //Get user save in local
  Future<UserMetadataModel?> getLocalUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataJson = prefs.getString('userData');

    if (userDataJson != null) {
      final Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
      return UserMetadataModel.fromJson(userDataMap);
    }

    return null;
  }

  Future<void> createUserData(String userId, String displayName,
      String phoneNumber, String email) async {
    UserModel newUser = UserModel(
      displayName: displayName,
      avatarUrl: 'empty',
      phoneNumber: phoneNumber,
      email: email,
      address: 'Hanoi',
      point: 0,
      listChatRoom: [],
    );

    await _firebaseFirestore
        .collection('users')
        .doc(userId)
        .set(newUser.toJson());
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //
  Future<UserCredential> signUp(String displayName, String phoneNumber,
      String email, String password) async {
    final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await createUserData(
      userCredential.user!.uid,
      displayName,
      phoneNumber,
      email,
    );
    return userCredential;
  }

  //Signout the current account
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //Update point on database
  Future<void> updateRewardPoint(String userDocId, int point) async {
    return await _firebaseFirestore
        .collection('users')
        .doc(userDocId)
        .update({'point': point});
  }
}
