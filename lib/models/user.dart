class UserProfile {
  String id;
  String username;
  String avtURL;

  UserProfile({required this.username, required this.avtURL, required this.id});
  UserProfile.fromJson(Map<String, dynamic> json)
      : username = json['username'].toString(),
        id = json['_id'].toString(),
        avtURL = '';
}
