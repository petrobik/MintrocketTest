class GithubRepository {
  GithubRepository(
      {required this.id,
      required this.name,
      required this.owner,
      required this.description,
      required this.url});

  int id;
  String name;
  Owner owner;
  String description;
  String url;

  factory GithubRepository.fromJson(Map<String, dynamic> json) =>
      GithubRepository(
        id: json["id"],
        name: json["name"],
        owner: Owner.fromJson(json["owner"]),
        description: json["description"] == null ? '' : json["description"],
        url: json["html_url"],
      );
}

class Owner {
  Owner({
    required this.login,
    required this.id,
    required this.avatarUrl,
  });

  String login;
  int id;
  String avatarUrl;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"],
        id: json["id"],
        avatarUrl: json["avatar_url"],
      );
}
