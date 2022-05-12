class User {
  int? id;
  String? email, name, about, education, picture;

  User(
      {this.id,
      this.email,
      this.name,
      this.about,
      this.education,
      this.picture});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      about: json['about'],
      education: json['education'],
      picture: json['picture']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'about': about,
        'education': education,
        'picture': picture,
      };
}
