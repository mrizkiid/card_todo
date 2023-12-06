class ModelAuthUser {
  final String uuid;
  final String email;
  final String? name;
  final String? photoUrl;

  const ModelAuthUser({
    required this.uuid,
    required this.email,
    this.name,
    this.photoUrl,
  });
}
