class Employee {
  int? id;
  String? firstName;
  String? lastName;
  String? maidenName;
  int? age;
  String? gender;
  String? email;
  String? phone;
  String? username;
  String? password;
  String? birthDate;
  String? image;
  String? bloodGroup;
  double? height;
  double? weight;
  String? eyeColor;

  String? ip;
  Address? address;
  String? macAddress;
  String? university;

  Company? company;
  String? ein;
  String? ssn;
  String? userAgent;

  String? role;

  Employee(
      {this.id,
      this.firstName,
      this.lastName,
      this.maidenName,
      this.age,
      this.gender,
      this.email,
      this.phone,
      this.username,
      this.password,
      this.birthDate,
      this.image,
      this.bloodGroup,
      this.height,
      this.weight,
      this.eyeColor,
      this.ip,
      this.address,
      this.macAddress,
      this.university,
      this.company,
      this.ein,
      this.ssn,
      this.userAgent,
      this.role});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    maidenName = json['maidenName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    birthDate = json['birthDate'];
    image = json['image'];
    bloodGroup = json['bloodGroup'];
    height = json['height'];
    weight = json['weight'];
    eyeColor = json['eyeColor'];
    ip = json['ip'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    macAddress = json['macAddress'];
    university = json['university'];

    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    ein = json['ein'];
    ssn = json['ssn'];
    userAgent = json['userAgent'];

    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['maidenName'] = maidenName;
    data['age'] = age;
    data['gender'] = gender;
    data['email'] = email;
    data['phone'] = phone;
    data['username'] = username;
    data['password'] = password;
    data['birthDate'] = birthDate;
    data['image'] = image;
    data['bloodGroup'] = bloodGroup;
    data['height'] = height;
    data['weight'] = weight;
    data['eyeColor'] = eyeColor;

    data['ip'] = ip;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['macAddress'] = macAddress;
    data['university'] = university;

    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['ein'] = ein;
    data['ssn'] = ssn;
    data['userAgent'] = userAgent;

    data['role'] = role;
    return data;
  }
}

class Address {
  String? address;
  String? city;
  String? state;
  String? stateCode;
  String? postalCode;

  String? country;

  Address(
      {this.address,
      this.city,
      this.state,
      this.stateCode,
      this.postalCode,
      this.country});

  Address.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    stateCode = json['stateCode'];
    postalCode = json['postalCode'];

    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['stateCode'] = stateCode;
    data['postalCode'] = postalCode;

    data['country'] = country;
    return data;
  }
}

class Company {
  String? department;
  String? name;
  String? title;
  Address? address;

  Company({this.department, this.name, this.title, this.address});

  Company.fromJson(Map<String, dynamic> json) {
    department = json['department'];
    name = json['name'];
    title = json['title'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['department'] = department;
    data['name'] = name;
    data['title'] = title;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}
