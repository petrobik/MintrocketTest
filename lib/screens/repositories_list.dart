import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mintrocket_test/constants.dart';
import 'package:mintrocket_test/cubit/repositories_cubit.dart';
import 'package:mintrocket_test/models/github_repository.dart';
import 'package:mintrocket_test/screens/repository_details.dart';

class RepositoriesList extends StatefulWidget {
  _RepositoriesListState createState() => _RepositoriesListState();
}

class _RepositoriesListState extends State<RepositoriesList> {
  ScrollController _scrollController = ScrollController();
  List<GithubRepository> _repos = [];

  @override
  void initState() {
    BlocProvider.of<RepositoriesCubit>(context).loadRepos();
    initScrollController();
    super.initState();
  }

  void initScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          BlocProvider.of<RepositoriesCubit>(context).loadRepos();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Repositories List'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder<RepositoriesCubit, RepositoriesState>(
        builder: (context, state) {
      if (state is RepositoriesLoading && state.isFirstFetch) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      bool isLoading = false;

      if (state is RepositoriesLoading) {
        _repos = state.oldRepos;
        isLoading = true;
      } else if (state is RepositoriesLoaded) {
        _repos = state.repos;
      }

      return RefreshIndicator(
        onRefresh: () {
          _repos.clear();
          return Future.delayed(Duration(milliseconds: 50),
              () => BlocProvider.of<RepositoriesCubit>(context).refresh());
        },
        child: ListView.separated(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: _repos.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < _repos.length) {
              return Padding(
                  padding: EdgeInsets.only(
                      top: index == 0 ? 16.0 : 0,
                      bottom: index == _repos.length - 1 ? 16.0 : 0),
                  child: _repositoryItem(_repos[index]));
            } else {
              Future.delayed(Duration(milliseconds: 30), () {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.0,
            );
          },
        ),
      );
    });
  }

  Widget _repositoryItem(GithubRepository item) {
    return GestureDetector(
      onTap: () => Get.to(RepositoryDetails(repositoryUrl: item.url)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Container(
          decoration: BoxDecoration(
              color: kBackgroundColor,
              boxShadow: [
                BoxShadow(
                    blurRadius: 4.0,
                    offset: Offset(0, 2.0),
                    color: Colors.black.withOpacity(0.1))
              ],
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  ),
                  Text(item.owner.login)
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(item.description),
              SizedBox(
                height: 8.0,
              ),
              Text(item.id.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
