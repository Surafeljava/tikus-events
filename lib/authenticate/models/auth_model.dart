class AuthModel{

  final int userId;
  final String userName;
  final String email;
  final String password;
  final String createdOn;
  final String profileUrl;
  final bool admin;

  AuthModel({
    this.userId,
    this.userName,
    this.email,
    this.password,
    this.createdOn,
    this.profileUrl,
    this.admin });

  factory AuthModel.fromJson(dynamic json){
    return AuthModel(
        userId: json['user_id'],
        userName: json['user_name'],
        email: json['email'],
        createdOn: json['created_on'],
        profileUrl: json['profile_url'],
        admin: json['admin'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'user_id': userId,
        'user_name': userName,
        'email': email,
        'created_on': createdOn,
        'profile_url': profileUrl,
        'admin': admin
      };


}