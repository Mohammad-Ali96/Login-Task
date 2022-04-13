
class UserInfo {
  final String id;
  final String name;
  final String email;


  UserInfo({
    required this.id,
    required this.name,
    required this.email,
  });

  UserInfo copyWith({
    String? name,
    String? email,
  }) {
    return UserInfo(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
