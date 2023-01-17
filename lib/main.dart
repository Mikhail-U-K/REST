import 'package:flutter/material.dart';
import 'package:rest_app/bloc/app_bloc.dart';
import 'package:rest_app/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
          RepositoryProvider.of<UserRepository>(context, listen: false)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('REST APP'),
        ),
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) => state.map(
            error: (state) => Center(child: Text(state.errorMessage)),
            loading: (state) {
              context.read<AppBloc>().add(const AppEvent.started());
              return const Center(child: CircularProgressIndicator());
            },
            loaded: (state) => ListView.builder(
              itemBuilder: (_, index) {
                return Card(
                  color: Colors.blue,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(
                      state.users[index].first_name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      state.users[index].last_name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    trailing: CircleAvatar(
                      backgroundImage: NetworkImage(state.users[index].avatar),
                    ),
                  ),
                );
              },
              itemCount: state.users.length,
            ),
          ),
        ),
      ),
    );
  }
}
