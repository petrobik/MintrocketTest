import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mintrocket_test/models/github_repository.dart';
import 'package:mintrocket_test/repositories/repository.dart';

part 'repositories_state.dart';

class RepositoriesCubit extends Cubit<RepositoriesState> {
  RepositoriesCubit(this.repository) : super(RepositoriesInitial());

  int page = 1;
  final Repository repository;

  void loadRepos() {
    if (state is RepositoriesLoading) return;

    final currentState = state;

    var oldRepos = <GithubRepository>[];
    if (currentState is RepositoriesLoaded) {
      oldRepos = currentState.repos;
    }

    emit(RepositoriesLoading(oldRepos: oldRepos, isFirstFetch: page == 1));

    repository.fetchRepos(page).then((newRepos) {
      page++;

      final repos = (state as RepositoriesLoading).oldRepos;
      repos.addAll(newRepos);

      emit(RepositoriesLoaded(repos));
    });
  }

  void refresh() {
    page = 1;

    loadRepos();
  }
}
