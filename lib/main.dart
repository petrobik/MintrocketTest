import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mintrocket_test/cubit/repositories_cubit.dart';
import 'package:mintrocket_test/network/api_client.dart';
import 'package:mintrocket_test/repositories/repository.dart';
import 'package:mintrocket_test/screens/repositories_list.dart';

void main() {
  runApp(MintrocketTest(
    repository: Repository(ApiClient()),
  ));
}

class MintrocketTest extends StatelessWidget {
  final Repository repository;

  const MintrocketTest({required this.repository});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mintrocket Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => RepositoriesCubit(repository),
        child: RepositoriesList(),
      ),
    );
  }
}
