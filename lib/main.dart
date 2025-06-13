import 'package:f_bloc/home/data/datasources/weather_data_provider.dart';
import 'package:f_bloc/home/data/repos/weather_repo.dart';
import 'package:f_bloc/home/presentation/bloc/weather_bloc.dart';
import 'package:f_bloc/home/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepo(WeatherDataProvider()),
      child: BlocProvider(
        create: (context) => WeatherBloc(context.read<WeatherRepo>()),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: WeatherPage(),
        ),
      ),
    );
  }
}
