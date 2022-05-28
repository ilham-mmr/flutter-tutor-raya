class User {
  int? id;
  String? email, name, about, education, picture, phoneNumber;

  User(
      {this.id,
      this.email,
      this.name,
      this.about,
      this.education,
      this.picture,
      this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      about: json['about'],
      education: json['education'],
      phoneNumber: json['phone_number'],
      picture: json['picture']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'about': about,
        'education': education,
        'phone_number': phoneNumber,
        'picture': picture,
      };
}
