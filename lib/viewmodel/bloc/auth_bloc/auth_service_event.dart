import 'package:coffee_online_store/model/models/user_metadata_model.dart';

abstract class AuthServiceEvent {}

class GetLocalUserProfile extends AuthServiceEvent {}

class SaveLocalUserProfile extends AuthServiceEvent {
  final UserMetadataModel userMetadata;

  SaveLocalUserProfile(this.userMetadata);
}
