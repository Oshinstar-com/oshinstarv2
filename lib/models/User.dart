class Category {
  final String name;
  final String description;

  Category({required this.name, required this.description});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

class User {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime birthdate;
  final String phone;
  final String location;
  final List<Category> categories;
  final bool isPhoneVerified;
  final bool isEmailVerified;

  User({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthdate,
    required this.phone,
    required this.location,
    required this.categories,
    this.isPhoneVerified = false,
    this.isEmailVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var categoriesFromJson = json['categories'] as List;
    List<Category> categoryList = categoriesFromJson.map((i) => Category.fromJson(i)).toList();

    return User(
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      birthdate: DateTime.parse(json['birthdate']),
      phone: json['phone'],
      location: json['location'],
      categories: categoryList,
      isPhoneVerified: json['isPhoneVerified'] ?? false,
      isEmailVerified: json['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'birthdate': birthdate.toIso8601String(),
      'phone': phone,
      'location': location,
      'categories': categories.map((category) => category.toJson()).toList(),
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
    };
  }
}
