import 'dart:convert';

class User {
  final String image;
  final String name;
  final String role;
  final String email;
  final String snn;
  final String mobile_number;

  final String dob;

  final String licence;

  final String vehicle_type;

  final String experience;

  User({
    this.image,
    this.snn,
    this.name,
    this.role,
    this.email,
    this.licence,
    this.mobile_number,
    this.dob,
    this.vehicle_type,
    this.experience,
  });
  factory User.fromJson(Map<String, dynamic> Usertjson) => User(
        image: Usertjson["image"] != null
            ? Usertjson["image"]
            : "8c552a3e-b8cf-4892-b14e-b4ea848f0bd14916427681049663461.jpg",
        snn: Usertjson["snn"],
        name: Usertjson["name"],
        email: Usertjson["email"],
        licence: Usertjson["licence"],
        mobile_number: Usertjson["mobile_number"],
        role: Usertjson["role"],
        dob: Usertjson["dob"],
        vehicle_type: Usertjson["vehicle_type"],
        experience: Usertjson["experience"],
      );
}
