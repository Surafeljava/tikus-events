class DashBoardModel{

  final int users;
  final int events;
  final int registrations;

  DashBoardModel({this.users, this.events, this.registrations});

  factory DashBoardModel.fromJson(dynamic json){
    return DashBoardModel(
      users: json['users'],
      events: json['events'],
      registrations: json['registrations']
    );
  }

}