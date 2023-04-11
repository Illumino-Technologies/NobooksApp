abstract class User {
  final String id;
  final String firstname;
  final String lastname;
  final String profilePhoto;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profilePhoto,
  });

  Map<String, dynamic> toMap();

  User copyWith({
    String? id,
    String? firstname,
    String? profilePhoto,
    String? lastname,
  });
}
