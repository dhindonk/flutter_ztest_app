class Auth {
  int? id;
  String? fullName;
  String? email;
  String? password;
  String? image;
  int? score;
  int? token;

  Auth({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.image,
    this.score,
    this.token,
  });

  factory Auth.fromMap(Map<String, dynamic> map) => Auth(
        id: map['id'],
        fullName: map['fullName'],
        email: map['email'],
        password: map['password'],
        image: map['image'],
        score: map['score'],
        token: map['token'] == 1 ? 1 : 0,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'fullName': fullName,
        'email': email,
        'password': password,
        'image': image,
        'score': score,
        'token': token,
      };
}