class Admin {
  String? id;
  String? name;
  String? email;
  String? password;
  String? number;
  String? address;
  String? datereg;

  Admin({this.id, this.name, this.email, this.password,this.number, this.address, this.datereg});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    number = json['number'];
    address = json['address'];
    datereg = json['datereg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['number'] = number;
    data['address'] = address;
    data['datereg'] = datereg;
    return data;
  }
}