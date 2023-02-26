class User {
  final String firstname;
  final String profilePhoto;

  const User({
    required this.firstname,
    required this.profilePhoto,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'profilePhoto': profilePhoto,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstname: map['firstname'] as String,
      profilePhoto: map['profilePhoto'] as String,
    );
  }

  User copyWith({
    String? firstname,
    String? profilePhoto,
  }) {
    return User(
      firstname: firstname ?? this.firstname,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}
