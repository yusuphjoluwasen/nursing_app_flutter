class Signup {
  String firstname;
  String email;
  String hcp; // Assuming hcp is a String. Change to appropriate type if needed.
  String dateofbirth;
  String bio;
  String password;
  String userType;

  Signup({
    required this.firstname,
    required this.email,
    required this.hcp,
    required this.dateofbirth,
    required this.bio,
    required this.password,
    required this.userType,
  });

  // Method to convert JSON to Register object
  factory Signup.fromJson(Map<String, dynamic> json) {
    return Signup(
      firstname: json['firstname'],
      email: json['email'],
      hcp: json['hcp'],
      dateofbirth: json['dateofbirth'],
      bio: json['bio'],
      password: json['password'],
      userType: json['userType'],
    );
  }

  // Method to convert Register object to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'email': email,
      'hcp': hcp,
      'dateofbirth': dateofbirth,
      'bio': bio,
      'password': password,
      'userType': userType,
    };
  }
}
