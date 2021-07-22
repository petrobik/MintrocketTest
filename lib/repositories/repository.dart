import 'package:mintrocket_test/models/github_repository.dart';
import 'package:mintrocket_test/network/api_client.dart';

class Repository {
  final ApiClient apiClient;

  Repository(this.apiClient);

  Future<List<GithubRepository>> fetchRepos(int page) async {
    final repos = await apiClient.fetchRepos(page);
    return repos.map((repo) => GithubRepository.fromJson(repo)).toList();
  }
}
