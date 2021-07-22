part of 'repositories_cubit.dart';

abstract class RepositoriesState extends Equatable {
  const RepositoriesState();

  @override
  List<Object> get props => [];
}

class RepositoriesInitial extends RepositoriesState {}

class RepositoriesLoaded extends RepositoriesState {
  final List<GithubRepository> repos;

  RepositoriesLoaded(this.repos);
}

class RepositoriesLoading extends RepositoriesState {
  final List<GithubRepository> oldRepos;
  final bool isFirstFetch;

  RepositoriesLoading({required this.oldRepos, required this.isFirstFetch});
}
