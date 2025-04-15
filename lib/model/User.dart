
// for manual serialization
class User {
  int id;
  String name;
  String email;
  String gender;
  String status;
  String created_at;
  String updated_at;

  User({required this.id, required this.name, required this.email,required this.gender, required this.status, required this.created_at, required this.updated_at});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'status': status,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}

