import 'package:isar/isar.dart';

part 'local_user.g.dart';

@collection
class LocalUser {
  Id? id;
  @Index(unique: true)
  String? userId;
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? gender;
  DateTime? birthdate;
  String? phone;
  String? location;
  List<String>? categories;
  bool? isPhoneVerified;
  bool? isEmailVerified;
  int? attempts;
  bool? canUpdatePhoneCode;
  String? accountType;
  List<String>? images;
  List<String>? videos;
  List<String>? tracks;
  List<String>? collections;

  LocalUser({
    this.id,
    this.userId,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthdate,
    this.phone,
    this.location,
    this.categories,
    this.isPhoneVerified,
    this.isEmailVerified,
    this.attempts,
    this.canUpdatePhoneCode,
    this.accountType,
    this.images,
    this.videos,
    this.tracks,
    this.collections,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'birthdate': birthdate?.toIso8601String(),
      'phone': phone,
      'location': location,
      'categories': categories,
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
      'attempts': attempts,
      'canUpdatePhoneCode': canUpdatePhoneCode,
      'accountType': accountType,
      'images': images,
      'videos': videos,
      'tracks': tracks,
      'collections': collections,
    };
  }

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      id: json['id'],
      userId: json['userId'],
      email: json['email'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      birthdate: DateTime.tryParse(json['birthdate']),
      phone: json['phone'],
      location: json['location'],
      categories: List<String>.from(json['categories']),
      isPhoneVerified: json['isPhoneVerified'],
      isEmailVerified: json['isEmailVerified'],
      attempts: json['attempts'],
      canUpdatePhoneCode: json['canUpdatePhoneCode'],
      accountType: json['accountType'],
      images: List<String>.from(json['images']),
      videos: List<String>.from(json['videos']),
      tracks: List<String>.from(json['tracks']),
      collections: List<String>.from(json['collections']),
    );
  }
}
