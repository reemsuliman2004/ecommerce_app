// lib/model/profile_model.dart

class Profile {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;


  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,

  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profile_image'],


    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,


    };
  }
}
