class User {
  final int id;

  User.fromJson(dynamic json) : id = json['id'];

  Map<String, dynamic> toJson() => {'id': id};
}
