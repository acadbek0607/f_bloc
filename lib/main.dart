import 'package:f_bloc/auth/presentation/bloc/app_bloc_observer.dart';
import 'package:f_bloc/auth/presentation/bloc/auth_bloc.dart';
import 'package:f_bloc/auth/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:f_bloc/auth/core/utils/pallete.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlockObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Pallete.backgroundColor,
        ),
        home: LoginPage(),
      ),
    );
  }
}
