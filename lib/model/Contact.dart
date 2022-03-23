class Contact {
  late final String firstname;
  late final String lastname;
  late final String email;
  late final String image;
  late final String location;
  late final String bio;


  Contact({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.image,
    required this.location,
    required this.bio});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      location: json['location'] as String,
      bio: json['bio'] as String
    );
  }
}

